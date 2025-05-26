import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../../di/di.dart';
import '../controller/task_controller.dart';

// Repository Provider
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return getIt<TaskRepository>();
});

// Task Controller Provider
final taskControllerProvider = StateNotifierProvider<TaskController, List<TaskEntity>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskController(repository);
});
