import 'dart:async';
import 'package:floor/floor.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


import '../../domain/entities/task_entity.dart';
import 'dao/task_dao.dart';


part 'local_database.g.dart';

@Database(version: 1, entities: [TaskEntity])
abstract class LocalDatabase extends FloorDatabase {
  @injectable
  TaskDao get taskDao;
}
