# taskmanager

A Task manager app where you can save your upcoming tasks and stay organized.

To build this
## Requirements
- Flutter SDK installed (installation guide).
- Dart installed (comes with Flutter SDK).
- An IDE like VS Code or Android Studio.

## Getting Started
1. Clone the Repository
`git clone https://github.com/your-username/flutter-task-management.git`
`cd flutter-task-management`

2. Install Dependencies
Ensure Flutter and Dart are installed and available in your system PATH. Run the following command in the project directory:

`flutter pub get`


3. Configure FireBase on your device
run `flutterfire configure --project=your_project_name_firebase`

make sure you put the api keys in key.env file, and link them to `lib/firebase_options.dart`

4. Run the app

- goto main.dart
- click run

or

in terminal in the root directory 
`flutter run`

## File Structure of app

lib/
├── main.dart           // App entry point
├── core/               // Shared utilities, constants, and themes
│   ├── utils/
│   ├── constants.dart
│   ├── theme.dart
├── features/           // Separate features for modularity
│   ├── auth/
│   │   ├── data/
│   │   │   ├── auth_repository.dart
│   │   │   ├── auth_remote_data_source.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── usecases/
│   │   ├── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       │   ├── login_screen.dart
│   │       │   ├── signup_screen.dart
│   ├── tasks/
│       ├── model/      // Data-related logic
│   │   │   ├── task.dart                // Data model
│   │   │   ├── task_repository.dart     // Repository interface
│   │   │   ├── task_remote_data_source.dart
│   │   │   ├── task_local_data_source.dart
│   │   ├── viewmodel/  // Business logic and state
│   │   │   ├── task_list_viewmodel.dart
│   │   │   ├── task_detail_viewmodel.dart
│   │   ├── view/       // UI layer
│   │       ├── screens/
│   │       │   ├── task_list_screen.dart
│   │       │   ├── task_detail_screen.dart
│   │       ├── widgets/
├── shared/             // Common widgets and helpers
│   ├── widgets/
│   ├── services/       // Network and storage utilities
│   │   ├── api_client.dart
│   │   ├── local_storage.dart
├── test/               // Unit and widget tests

