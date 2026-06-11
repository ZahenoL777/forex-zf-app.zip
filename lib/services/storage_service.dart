import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

class StorageService {
  static const String _todoListKey = 'todo_list';
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save all todos
  Future<void> saveTodos(List<TodoModel> todos) async {
    final jsonList = todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await _prefs.setStringList(_todoListKey, jsonList);
  }

  // Load all todos
  Future<List<TodoModel>> loadTodos() async {
    final jsonList = _prefs.getStringList(_todoListKey) ?? [];
    return jsonList
        .map((json) => TodoModel.fromJson(jsonDecode(json)))
        .toList();
  }

  // Add a single todo
  Future<void> addTodo(TodoModel todo) async {
    final todos = await loadTodos();
    todos.add(todo);
    await saveTodos(todos);
  }

  // Update a todo
  Future<void> updateTodo(TodoModel todo) async {
    final todos = await loadTodos();
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await saveTodos(todos);
    }
  }

  // Delete a todo
  Future<void> deleteTodo(String id) async {
    final todos = await loadTodos();
    todos.removeWhere((t) => t.id == id);
    await saveTodos(todos);
  }

  // Clear all todos
  Future<void> clearAllTodos() async {
    await _prefs.remove(_todoListKey);
  }

  // Get todo by id
  Future<TodoModel?> getTodoById(String id) async {
    final todos = await loadTodos();
    try {
      return todos.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get todos by status
  Future<List<TodoModel>> getTodosByStatus(bool completed) async {
    final todos = await loadTodos();
    return todos.where((t) => t.isCompleted == completed).toList();
  }

  // Get todos by priority
  Future<List<TodoModel>> getTodosByPriority(String priority) async {
    final todos = await loadTodos();
    return todos.where((t) => t.priority == priority).toList();
  }

  // Get overdue todos
  Future<List<TodoModel>> getOverdueTodos() async {
    final todos = await loadTodos();
    return todos.where((t) => t.isOverdue).toList();
  }
}