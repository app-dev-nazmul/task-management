import 'dart:ui';

class AppConstants {
  // App Information
  static const String appName = "Task Management";
  static const String greetingsName = "Good morning Liam!";
  static const String defaultUserName = "User";
  static const String greetingsPrefix = "Good morning";

  static const String descriptionTooLong = 'Description cannot exceed 200 characters';

  // Create Task Screen
  static const String createTaskTitle = "Create new task";
  static const String taskNameLabel = "Task Name";
  static const String taskNameHint = "Enter Your Task Name";
  static const String taskDescriptionLabel = "Task description";
  static const String taskDescriptionHint = "Enter Task Description";
  static const String startDateLabel = "Start Date";
  static const String endDateLabel = "End Date";
  static const String createTaskButtonText = "Create new tasks";

  // Task Management
  static const String taskTitle = 'Task Title';
  static const String taskDescription = 'Task Description';
  static const String startDate = 'Start Date';
  static const String endDate = 'End Date';
  static const String status = 'Status';
  static const String addTask = 'Add Task';
  static const String updateTask = 'Update Task';
  static const String deleteTask = 'Delete Task';

  // Messages
  static const String taskNotFound = 'Task not found';
  static const String somethingWentWrong = 'Something went wrong. Please try again.';
  static const String taskAdded = 'Task added successfully';
  static const String taskUpdated = 'Task updated successfully';
  static const String taskDeleted = 'Task deleted successfully';
  static const String taskCreatedSuccess = 'Task created successfully';

  // Validation Messages
  static const String taskNameRequired = 'Task name is required';
  static const String taskDescriptionRequired = 'Task description is required';
  static const String datesRequired = 'Start and end dates are required';
  static const String invalidDateRange = 'End date must be after start date';

  // Summary Section Constants
  static const String summaryTitle = "Summary";
  static const String assignedTasks = "Assigned tasks";
  static const String completedTasks = "Completed tasks";

  // Task Statuses
  static const String statusAssigned = "Assigned";
  static const String statusCompleted = "Completed";

  // UI Constants
  static const int maxDescriptionLines = 5;
  static const int maxDescriptionLength = 200;
  static const String dateFormat = 'MMMM dd, yyyy';
  static const String emptyString = '';
  static const Color primaryButtonColor = Color(0xFF6C40F2);
}