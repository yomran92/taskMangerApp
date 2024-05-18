import 'package:hive/hive.dart';

import '../../../../../core/data_sources/remote_data_source.dart';
import '../../models/get_all_task_model.dart';
import '../../models/param/add_new_task_param.dart';
import '../../models/param/delete_task_param.dart';
import '../../models/param/get_all_task_param.dart';
import '../../models/param/get_task_by_id_param.dart';
import '../../models/param/update_task_param.dart';
import '../../models/task_model.dart';

abstract class ITaskRemoteDataSource extends RemoteDataSource {
  Future<GetAllTaskModel> getAllTask(GetAllTaskParams params);

  Future<TaskModel> addNewTask(AddTaskParams params);

  Future<TaskModel> deleteTask(DeleteTaskParams params);

  Future<TaskModel> updateTask(UpdateTaskParams params);

  Future<TaskModel> getTaskById(GetTaskByIDParams params);
}

class TaskRemoteDataSource extends ITaskRemoteDataSource {
  final HiveInterface? hiveInterface;

  TaskRemoteDataSource(
    this.hiveInterface,
  );

  @override
  Future<TaskModel> addNewTask(AddTaskParams params) async {
    var res = await this.post(params);
    return Future.value(TaskModel.fromJson(res));
  }

  @override
  Future<TaskModel> getTaskById(GetTaskByIDParams params) async {
    var res = await this.get(params);
    return Future.value(TaskModel.fromJson(res));
  }

  @override
  Future<TaskModel> deleteTask(DeleteTaskParams params) async {
    //
    var res;

    res = await this.delete(params);

    return Future.value(TaskModel.fromJson(res));
  }

  @override
  Future<GetAllTaskModel> getAllTask(GetAllTaskParams params) async {
    var res;

    res = await this.get(params, withToken: true);

    return Future.value(GetAllTaskModel.fromJson(res));
  }

  @override
  Future<TaskModel> updateTask(UpdateTaskParams params) async {
    //
    var res;

    res = await this.put(params);

    return Future.value(TaskModel.fromJson(res));

    //
  }
}
