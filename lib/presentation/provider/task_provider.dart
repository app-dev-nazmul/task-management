  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import '../../domain/entities/task_entity.dart';
  import '../../domain/repositories/task_repository.dart';
  import '../../di/di.dart';
  import '../../domain/use_case/task_usecase.dart';
import '../controller/task_controller.dart';

  // final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  //   return getIt<TaskRepository>();
  // });
  //
  // final taskControllerProvider = StateNotifierProvider<TaskController, List<TaskEntity>>((ref) {
  //   final repository = ref.watch(taskRepositoryProvider);
  //   return TaskController(repository);
  // });

  final taskControllerProvider =
  StateNotifierProvider<TaskController, List<TaskEntity>>((ref) {
    return TaskController(
      repository: getIt<TaskRepository>(),
      createTaskUseCase: getIt<CreateTaskUseCase>(),
      updateTaskUseCase: getIt<UpdateTaskUseCase>(),
      deleteTaskUseCase: getIt<DeleteTaskUseCase>(),
    );
  });