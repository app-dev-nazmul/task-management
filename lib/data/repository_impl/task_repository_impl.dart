import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../database/dao/task_dao.dart';
import '../models/storage_key.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final TaskDao _taskDao;

  TaskRepositoryImpl(this._taskDao);

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    try {
      return await _taskDao.getAllTasks();
    } catch (e) {
      throw Exception('Failed to get all tasks: $e');
    }
  }

  @override
  Future<TaskEntity?> getTaskById(String id) async {
    try {
      return await _taskDao.getTaskById(id);
    } catch (e) {
      throw Exception('Failed to get task by id: $e');
    }
  }

  @override
  Future<List<TaskEntity>> getTasksByStatus(String status) async {
    try {
      return await _taskDao.getTasksByStatus(status);
    } catch (e) {
      throw Exception('Failed to get tasks by status: $e');
    }
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    try {
      await _taskDao.insertTask(task);
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    try {
      await _taskDao.updateTask(task);
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  @override
  Future<void> deleteTask(TaskEntity task) async {
    try {
      await _taskDao.deleteTask(task);
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
