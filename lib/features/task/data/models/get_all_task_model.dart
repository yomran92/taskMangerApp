import 'package:hive/hive.dart';

import '../../domain/entities/get_all_task_entity.dart';
import '../../domain/entities/get_task_entity.dart';
import 'task_model.dart';


part 'get_all_task_model.g.dart';

@HiveType(typeId: 1)
class GetAllTaskModel {
  @HiveField(0)
  List<TaskModel>? taskList = [];

  GetAllTaskModel({required this.taskList});

  factory GetAllTaskModel.fromJson(json) {
    return GetAllTaskModel(taskList: json.toList().cast<TaskModel>());
  }
  //
  // factory GetAllTodoModel.fromSnapshot(
  //     Map<String, dynamic> json) {
  //   List<TodoModel>? todoListTmp = [];
  //   if (json!= null) {
  //     todoListTmp = <TodoModel>[];
  //     json.forEach((v) {
  //       todoListTmp!.add(  TodoModel.fromJson(v));
  //     });
  //   }
  //
  //   return GetAllTodoModel(todoList: todoListTmp);
  // }

  Map<String, dynamic> toJson() {
    return {"todoList": this.taskList!.map((v) => v.toJson()).toList()};
  }

  @override
  GetAllTaskEntity toEntity() {
    List<GetTaskEntity>? taskEntityList = [];
    for (var a in taskList!) {
      taskEntityList.add(a.toEntity());
    }
    return GetAllTaskEntity(taskList: taskEntityList);
  }
}
