import 'package:hive/hive.dart';

import '../../domain/entities/get_task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? content;
  @HiveField(3)
  bool? synced;
  TaskModel(
      {required this.id,
      required this.title,
      required this.synced,
      required this.content});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      synced: json['synced'] ?? false,
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "synced": this.synced,
      "content": this.content
    };
  }

  @override
  GetTaskEntity toEntity() {
    return GetTaskEntity(
      id: id,
      title: title,
      content: content,
      synced: synced,
    );
  }
}
