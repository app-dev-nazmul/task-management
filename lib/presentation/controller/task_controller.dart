import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';

class TaskController extends StateNotifier<List<TaskEntity>> {
  final TaskRepository _repository;

  TaskController(this._repository) : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      final tasks = await _repository.getAllTasks();
      state = tasks;
    } catch (e) {
      // Handle error - you can add error state if needed
      print('Error loading tasks: $e');
    }
  }

  Future<void> createTask({
    required String title,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final task = TaskEntity(
        id: const Uuid().v4(),
        title: title,
        description: description,
        startDate: startDate,
        endDate: endDate,
        status: 'Assigned',
      );

      await _repository.createTask(task);
      await loadTasks(); // Refresh list
    } catch (e) {
      print('Error creating task: $e');
      rethrow;
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    try {
      await _repository.updateTask(task);
      await loadTasks(); // Refresh list
    } catch (e) {
      print('Error updating task: $e');
      rethrow;
    }
  }

  Future<void> deleteTask(TaskEntity task) async {
    try {
      await _repository.deleteTask(task);
      await loadTasks(); // Refresh list
    } catch (e) {
      print('Error deleting task: $e');
      rethrow;
    }
  }
}
