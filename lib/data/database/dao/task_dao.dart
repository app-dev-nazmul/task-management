import 'package:floor/floor.dart';
import '../../../domain/entities/task_entity.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM TaskEntity')
  Future<List<TaskEntity>> getAllTasks();

  @Query('SELECT * FROM TaskEntity WHERE id = :id')
  Future<TaskEntity?> getTaskById(String id);

  @Query('SELECT * FROM tasks WHERE status = :status')
  Future<List<TaskEntity>> getTasksByStatus(String status);


  @insert
  Future<void> insertTask(TaskEntity task);

  @update
  Future<void> updateTask(TaskEntity task);

  @delete
  Future<void> deleteTask(TaskEntity task);

}
