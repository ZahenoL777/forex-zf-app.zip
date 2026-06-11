import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';
import '../services/storage_service.dart';

class TodoProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  List<TodoModel> _todos = [];
  bool _isLoading = false;

  List<TodoModel> get todos => _todos;
  bool get isLoading => _isLoading;

  List<TodoModel> get activeTodos => _todos.where((t) => !t.isCompleted).toList();
  List<TodoModel> get completedTodos => _todos.where((t) => t.isCompleted).toList();
  List<TodoModel> get overdueTodos => _todos.where((t) => t.isOverdue).toList();

  int get totalTodos => _todos.length;
  int get completedCount => completedTodos.length;
  int get activeCount => activeTodos.length;

  TodoProvider() {
    _initializeStorage();
  }

  Future<void> _initializeStorage() async {
    await _storageService.init();
    await loadTodos();
  }

  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _todos = await _storageService.loadTodos();
      // Sort by created date, newest first
      _todos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      print('Error loading todos: $e');
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTodo(String title, {String description = '', DateTime? dueDate, String priority = 'medium'}) async {
    const uuid = Uuid();
    final newTodo = TodoModel(
      id: uuid.v4(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
      dueDate: dueDate,
      priority: priority,
    );

    try {
      await _storageService.addTodo(newTodo);
      _todos.insert(0, newTodo);
      notifyListeners();
    } catch (e) {
      print('Error adding todo: $e');
      rethrow;
    }
  }

  Future<void> updateTodo(String id, {
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    String? priority,
  }) async {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final updatedTodo = _todos[index].copyWith(
      title: title,
      description: description,
      isCompleted: isCompleted,
      dueDate: dueDate,
      priority: priority,
    );

    try {
      await _storageService.updateTodo(updatedTodo);
      _todos[index] = updatedTodo;
      notifyListeners();
    } catch (e) {
      print('Error updating todo: $e');
      rethrow;
    }
  }

  Future<void> toggleTodo(String id) async {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final todo = _todos[index];
    await updateTodo(id, isCompleted: !todo.isCompleted);
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _storageService.deleteTodo(id);
      _todos.removeWhere((t) => t.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting todo: $e');
      rethrow;
    }
  }

  Future<void> clearAllTodos() async {
    try {
      await _storageService.clearAllTodos();
      _todos.clear();
      notifyListeners();
    } catch (e) {
      print('Error clearing todos: $e');
      rethrow;
    }
  }

  List<TodoModel> sortTodosByPriority() {
    final priorityMap = {'high': 0, 'medium': 1, 'low': 2};
    final sorted = [..._todos];
    sorted.sort((a, b) => (priorityMap[a.priority] ?? 3)
        .compareTo(priorityMap[b.priority] ?? 3));
    return sorted;
  }

  List<TodoModel> searchTodos(String query) {
    return _todos
        .where((t) =>
            t.title.toLowerCase().contains(query.toLowerCase()) ||
            t.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}