import 'package:hive/hive.dart';

import '../../domain/entities/get_all_task_entity.dart';
import '../../domain/entities/get_task_entity.dart';
import 'task_model.dart';

part 'get_all_task_model.g.dart';

@HiveType(typeId: 1)
class GetAllTaskModel {
  @HiveField(0)
  List<TaskModel>? todos;

  @HiveField(1)
  int? total;
  @HiveField(2)
  int? skip;
  @HiveField(3)
  int? limit;

  GetAllTaskModel({this.todos, this.total, this.skip, this.limit});

  GetAllTaskModel.fromJson(json) {
    if (json['todos'] != null) {
      todos = <TaskModel>[];
      json['todos'].forEach((v) {
        todos!.add(new TaskModel.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.todos != null) {
      data['todos'] = this.todos!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }

  @override
  GetAllTaskEntity toEntity() {
    List<GetTaskEntity> getTasksentities = [];
    if (todos == null) {
      todos = [];
    }
    todos!.forEach((element) {
      getTasksentities.add(element.toEntity());
    });
    return GetAllTaskEntity(
        total: total, limit: limit, skip: skip, todos: getTasksentities);
  }
}
