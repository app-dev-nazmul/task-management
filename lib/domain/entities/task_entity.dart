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
  final String createdAt;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt
  });
}


extension TaskEntityCopyWith on TaskEntity {
  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? startDate,
    String? endDate,
    String? status,
    String? createdAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}