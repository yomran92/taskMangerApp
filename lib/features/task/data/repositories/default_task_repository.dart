import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:todoapp/features/task/data/models/param/delete_task_param.dart';


import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/get_all_task_entity.dart';
import '../../domain/entities/get_task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../models/param/add_new_task_param.dart';
import '../models/param/get_all_task_param.dart';
import '../models/param/update_task_param.dart';

class DefaultTaskRepository implements TaskRepository {
  final TaskRemoteDataSource? remoteDataSource;

  DefaultTaskRepository( this.remoteDataSource);

  @override
  Future<Either<Failure, GetAllTaskEntity>> getAllTask(GetAllTaskParams params) async {
    try {
//check connection
      bool isConnected = sl<NetworkInfo>().connectivityNotifier.value !=
          ConnectivityResult.none;
      final taskData;
      // if (!isConnected) {
        taskData = await remoteDataSource!.getAllTask(params);
      // } else {
      //   taskData = await localDataSource!.getAllTask();
      // }
      return Right(taskData.toEntity());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, GetTaskEntity>> addNewTask(AddTaskParams task) async {
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
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, GetTaskEntity>> deleteTask(DeleteTaskParams params) async {
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
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, GetTaskEntity>> updateTask(UpdateTaskParams params) async {
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
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, GetAllTaskEntity>> syncTask() async {
    try {
      final taskData = await remoteDataSource!.syncData();

      return Right(taskData.toEntity());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
