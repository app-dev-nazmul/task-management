import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/use_case/task_usecase.dart';

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
    await updateTaskUseCase(task);
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await deleteTaskUseCase(id);
    await loadTasks();
  }
}