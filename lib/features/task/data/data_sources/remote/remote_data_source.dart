
import 'package:hive/hive.dart';
import 'package:todoapp/core/utils/hive_keys.dart';


import '../../../../../core/data_sources/remote_data_source.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/utils/hive_paramter.dart';
import '../../../../../service_locator.dart';
import '../../models/get_all_task_model.dart';
import '../../models/param/add_new_task_param.dart';
import '../../models/param/delete_task_param.dart';
import '../../models/param/get_all_task_param.dart';
import '../../models/param/update_task_param.dart';
import '../../models/task_model.dart';

abstract class ITaskRemoteDataSource  extends RemoteDataSource{
  Future<GetAllTaskModel> getAllTask(GetAllTaskParams params);

  Future<TaskModel> addNewTask(AddTaskParams params);

  Future<TaskModel>  deleteTask(DeleteTaskParams params);

  Future<TaskModel> updateTask(UpdateTaskParams  params);

  Future<GetAllTaskModel> syncData();
}

class TaskRemoteDataSource extends ITaskRemoteDataSource {
  final HiveInterface? hiveInterface;


  TaskRemoteDataSource(this.hiveInterface,);

   Future<GetAllTaskModel> syncData() async {
    final taskBox = await sl<HiveParamter>().hive.openBox("TaskBox",
        );
    GetAllTaskModel task = GetAllTaskModel.fromJson(taskBox.values);
    task.taskList!.removeWhere((element) => element.synced == true);


    return task;
  }

  @override
  Future<TaskModel> addNewTask(AddTaskParams params) async {

    var res ;
    try {
        res =  await this.post(params);

      } on Exception catch (e) {

      final TaskBox = await sl<HiveParamter>().hive
          .openBox(HiveKeys.taskBox,
      );

      // await noteCollectionRef.doc(noteId).get().then((note) {
      final newNote = params.body!;


      newNote.task.synced = false;
      await TaskBox.put(newNote.task.id,newNote.task);
      return Future.value(TaskModel.fromJson(newNote.task.toJson()));

      throw CacheException();

      throw e;
    }
    return Future.value(TaskModel.fromJson(res));
  }

  @override
  Future<TaskModel> deleteTask(DeleteTaskParams params) async {



     //
    var res ;
    try {
      res =  await this.delete(params);

    } on Exception catch (e) {

      final taskBox = await sl<HiveParamter>().hive
          .openBox(HiveKeys.taskBox,
      );
      final task = taskBox.get(params.body!.id);

       await taskBox.delete(params.body!.id);
      return Future.value(task);

      throw CacheException();

      throw e;
    }
    return Future.value(TaskModel.fromJson(res));

  }

  @override
  Future<GetAllTaskModel> getAllTask(GetAllTaskParams params) async {



    var res ;
    try {
      res =  await this.get(params);

    } on Exception catch (e) {


      final TaskBox = await sl<HiveParamter>().hive.box(HiveKeys.taskBox,
      ) ;

      final task = TaskBox.values;

      return Future.value(GetAllTaskModel.fromJson(task));
      throw CacheException();

    }
      //

    return Future.value(GetAllTaskModel.fromJson(res));


  }

  @override
  Future<TaskModel> updateTask(UpdateTaskParams params) async {


     //
    var res ;
    try {
      res =  await this.put(params);

    } on Exception catch (e) {

      final taskBox = await sl<HiveParamter>().hive
          .openBox(HiveKeys.taskBox,
      );
      params.body!.task.synced = false;
      taskBox.put(params.body!.task.id, params.body!.task!);
      return Future.value(TaskModel.fromJson(params.body!.task.toJson()));

      // throw CacheException();

      throw e;
    }
    return Future.value(TaskModel.fromJson(res));

    //

  }
}
