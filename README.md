# To-Do App

A **To-Do App** that provides users with the ability to manage their tasks efficiently. The app leverages **Firebase** for authentication and Firestore as a local database. It includes light and dark themes, localization support, and the ability to add, edit, and manage tasks with specific details, including day and time. The app is structured using the **MVVM** architectural pattern and uses **Provider** for state management.

---

## 🗂 Folder Structure

```plaintext
lib/
├── api/                            # Firebase authentication and Firestore integration
├── cubits/                         # State management (Cubit classes)
│   └── task_cubit.dart             # Example Cubit for task operations
├── home/                           # Home screen components
│   └── home_view.dart              # Main view for the task list
├── l10n/                           # Localization files
│   └── app_localizations.dart      # Localization setup
├── model/                          # Data models for tasks
│   └── task_model.dart             # Task data model
├── task/                           # Task-related components
│   ├── add_edit_task.dart          # Screen to add or edit tasks
│   ├── task_details.dart           # Detailed view of a task
│   └── task_list.dart              # Task list UI
├── utils/                          # Utility functions
│   ├── app_colors.dart             # Color palette configuration
│   ├── app_theme.dart              # Light and dark theme setup
│   ├── date_time_helpers.dart      # Date and time formatting utilities
│   └── images.dart                 # Image asset management
└── main.dart                       # Entry point of the application
```
📱 Features
-----------

1.  **Firebase Authentication**Users can log in or sign up using Firebase Authentication.
    
2.  **Firestore as Local Database**Stores tasks in Firestore, with real-time synchronization.
    
3.  **Light and Dark Theme**Toggle between light and dark themes for a personalized experience.
    
4.  **Localization**Supports multiple languages with files in the l10n/ folder.
    
5.  **Task Management**
    
    *   **Add Task**: Add a task with a title, description, date, and time.
        
    *   **Edit Task**: Modify the title, description, or timing of an existing task.
        
    *   **View Task Details**: Detailed view of a task's information.
        
6.  **MVVM Pattern**
    
    *   **Model**: Represents task data and authentication logic.
        
    *   **View**: Defines UI components and layouts.
        
    *   **ViewModel**: Manages business logic and interacts with Providers to supply data to the View.
        
7.  **Provider for State Management**Manages task states and authentication data across the app.
    

🌐 Localization

Localization setup is managed in the l10n/ folder. To add a new language:

1.  Create a new .arb file in the l10n/ folder.
    
2.  Add key-value pairs for translated text.
    
3.  Update app\_localizations.dart for the new language.
    



🖌 Theming

Themes and colors are managed in the utils/ folder:

*   app\_colors.dart: Defines the color palette.
    
*   app\_theme.dart: Configures light and dark themes.
    

📖 Task Features
----------------

### 1\. Add a Task

*   Users can create a task with the following details:
    
    *   Title
        
    *   Description
        
    *   Date
        
    *   Time
        

### 2\. Edit a Task

*   Modify the title, description, or timing of a task.
    

### 3\. Task List

*   Displays a list of all tasks.
    

### 4\. Task Details

*   View detailed information about a specific task.
    

🔍 State Management

State management is handled using **Provider**. Key providers include:

*   TaskProvider: Manages task CRUD operations.
    
*   AuthProvider: Manages user authentication state.
    

📄 Dependencies
---------------

Key dependencies used in this project:

*   provider: For state management.
    
*   firebase\_auth: For user authentication.
    
*   cloud\_firestore: For Firestore database operations.
    
*   flutter\_localizations: For localization support.


## video  📸



https://github.com/user-attachments/assets/c4d801e9-871e-4603-ad4a-85b5bc31b32b


