import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:todoapp/features/task/data/models/param/delete_task_param.dart';

import '../../../../core/error/app_exceptions.dart';
import '../../../../core/error/error_entity.dart';
import '../../../../core/utils/hive_keys.dart';
import '../../../../core/utils/hive_paramter.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/get_all_task_entity.dart';
import '../../domain/entities/get_task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../models/get_all_task_model.dart';
import '../models/param/add_new_task_param.dart';
import '../models/param/get_all_task_param.dart';
import '../models/param/get_task_by_id_param.dart';
import '../models/param/update_task_param.dart';

class DefaultTaskRepository implements TaskRepository {
  final TaskRemoteDataSource? remoteDataSource;

  DefaultTaskRepository(this.remoteDataSource);

  @override
  Future<Either<ErrorEntity, GetAllTaskEntity>> getAllTask(
      GetAllTaskParams params) async {
    try {
//check connection
      bool isConnected = sl<NetworkInfo>().connectivityNotifier.value !=
          ConnectivityResult.none;
      final taskData;
      taskData = await remoteDataSource!.getAllTask(params);
      final taskBox = await sl<HiveParamter>().hive.box(HiveKeys.taskBox);

      GetAllTaskModel? getAllTaskModelLocal = taskBox.get(HiveKeys.taskListKey);
      if (getAllTaskModelLocal == null) {
        getAllTaskModelLocal =
            GetAllTaskModel(skip: 0, total: 0, limit: 0, todos: []);
      }
      GetAllTaskModel getAllTaskModel = taskData as GetAllTaskModel;
      getAllTaskModelLocal.todos!.addAll(getAllTaskModel.todos ?? []);
      getAllTaskModelLocal.todos!.toSet().toList();
      taskBox.put(HiveKeys.taskListKey, taskData);

      return Right(taskData.toEntity());
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }

  @override
  Future<Either<ErrorEntity, GetTaskEntity>> addNewTask(
      AddTaskParams task) async {
    try {
      final taskData;
      // bool isConnected = sl<NetworkInfo>().connectivityNotifier.value !=
      //     ConnectivityResult.none;
      //
      // if (!isConnected) {
      taskData = await remoteDataSource!.addNewTask(task);
      // } else {
      //   taskData = await localDataSource!.addNewTask(task);

      // }
      return Right(taskData.toEntity());
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }

  @override
  Future<Either<ErrorEntity, GetTaskEntity>> deleteTask(
      DeleteTaskParams params) async {
    try {
      final taskData;
      bool isConnected = sl<NetworkInfo>().connectivityNotifier.value !=
          ConnectivityResult.none;

      // if (isConnected) {
      taskData = await remoteDataSource!.deleteTask(params);
      // } else {
      //   taskData = await localDataSource!.deleteTask(params);
      // }

      return Right(taskData.toEntity());
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }

  @override
  Future<Either<ErrorEntity, GetTaskEntity>> updateTask(
      UpdateTaskParams params) async {
    try {
      final taskData;
      bool isConnected = sl<NetworkInfo>().connectivityNotifier.value !=
          ConnectivityResult.none;

      // if (isConnected) {
      taskData = await remoteDataSource!.updateTask(params);
      // } else {
      // taskData = await localDataSource!.updateTask(Task);
      // }

      return Right(taskData.toEntity());
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }

  @override
  Future<Either<ErrorEntity, GetTaskEntity>> getTaskById(
      GetTaskByIDParams params) async {
    try {
      final taskData;

      taskData = await remoteDataSource!.getTaskById(params);

      return Right(taskData.toEntity());
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }
}
