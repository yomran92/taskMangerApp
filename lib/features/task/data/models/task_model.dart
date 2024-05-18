import 'package:hive/hive.dart';

import '../../domain/entities/get_task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? todo;
  @HiveField(2)
  bool? completed;
  @HiveField(3)
  int? userId;

  TaskModel({this.id, this.todo, this.completed, this.userId});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['todo'] = this.todo;
    data['completed'] = this.completed;
    data['userId'] = this.userId;
    return data;
  }

  @override
  GetTaskEntity toEntity() {
    return GetTaskEntity(
      id: id,
      todo: todo,
      completed: completed,
      userId: userId,
    );
  }
}
