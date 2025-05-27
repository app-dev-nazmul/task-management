import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/use_case/task_usecase.dart';

/*
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
        status: 'todo',
        createdAt: DateTime.now().toIso8601String().split('T').first,
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

  Future<void> deleteTask(String id) async {
    try {
      await _repository.deleteTask(id);
      await loadTasks(); // Refresh list
    } catch (e) {
      print('Error deleting task: $e');
      rethrow;
    }
  }
}
*/


class TaskController extends StateNotifier<List<TaskEntity>> {
  final TaskRepository repository;
  final CreateTaskUseCase createTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskController({
    required this.repository,
    required this.createTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final tasks = await repository.getAllTasks();
    state = tasks;
  }

  Future<void> createTask({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required String createdAt,
    required String status,
  }) async {
    await createTaskUseCase(
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
    );
    await loadTasks();
  }

  Future<void> updateTask(TaskEntity task) async {
    print('shfsdljsffsjl ${task}');
    print('shfsdljsffsjl2 ${task.status}');
    await updateTaskUseCase(task);
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await deleteTaskUseCase(id);
    await loadTasks();
  }
}