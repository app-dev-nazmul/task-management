import '../entities/task_entity.dart';

abstract class TaskRepository {
 Future<List<TaskEntity>> getAllTasks();
 Future<TaskEntity?> getTaskById(String id);
 Future<List<TaskEntity>> getTasksByStatus(String status);
 Future<void> createTask(TaskEntity task);
 Future<void> updateTask(TaskEntity task);
 Future<void> deleteTask(String id);
}
