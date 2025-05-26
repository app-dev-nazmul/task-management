import 'package:sqflite/sqflite.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';

import '../data/database/dao/task_dao.dart';
import '../data/database/local_database.dart';

@module
abstract class RegisterModule {

  @preResolve
  Future<LocalDatabase> get database async {
    final path = join(await getDatabasesPath(), 'task_database.db');
    return $FloorLocalDatabase.databaseBuilder(path).build();
  }

  @injectable
  TaskDao taskDao(LocalDatabase db) {
    return db.taskDao;
  }
}
