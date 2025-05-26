import 'package:floor/floor.dart';

@Entity(tableName: 'tasks')
class TaskEntity {
  @primaryKey
  final String id;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String status;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
  });
}