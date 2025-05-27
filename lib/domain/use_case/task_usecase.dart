import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

@LazySingleton()
class CreateTaskUseCase {
  final TaskRepository repository;

  CreateTaskUseCase(this.repository);

  Future<void> call({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final task = TaskEntity(
      id: const Uuid().v4(),
      title: title.trim(),
      description: description.trim(),
      startDate: _formatDate(startDate),
      endDate: _formatDate(endDate),
      status: 'todo',
      createdAt: _formatDate(DateTime.now()),
    );

    await repository.createTask(task);
  }

  String _formatDate(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date); // Or use AppConstants.dateFormat
}


@LazySingleton()
class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<void> call(TaskEntity updatedTask) async {
    await repository.updateTask(updatedTask);
  }
}


@LazySingleton()
class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<void> call(String taskId) async {
    await repository.deleteTask(taskId);
  }
}

@LazySingleton()
class TaskValidationResult {
  final bool isValid;
  final String? message;

  const TaskValidationResult(this.isValid, [this.message]);
}

@LazySingleton()
class ValidateTaskUseCase {
  TaskValidationResult call({
    required String title,
    required String description,
    required DateTime? startDate,
    required DateTime? endDate,
    int maxDescLength = 200,
  }) {
    if (title.trim().isEmpty) {
      return TaskValidationResult(false, 'Task name is required');
    }
    if (description.trim().isEmpty) {
      return TaskValidationResult(false, 'Task description is required');
    }
    if (description.length > maxDescLength) {
      return TaskValidationResult(false, 'Description too long');
    }
    if (startDate == null || endDate == null) {
      return TaskValidationResult(false, 'Dates are required');
    }
    if (endDate.isBefore(startDate)) {
      return TaskValidationResult(false, 'End date must be after start date');
    }

    return const TaskValidationResult(true);
  }
}