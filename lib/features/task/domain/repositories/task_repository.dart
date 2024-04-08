import 'package:dartz/dartz.dart';
import 'package:todoapp/features/task/data/models/param/delete_task_param.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/param/add_new_task_param.dart';
import '../../data/models/param/get_all_task_param.dart';
import '../../data/models/param/update_task_param.dart';
import '../entities/get_all_task_entity.dart';
import '../entities/get_task_entity.dart';

abstract class TaskRepository {
  Future<Either<Failure, GetAllTaskEntity>> getAllTask(GetAllTaskParams params);

  Future<Either<Failure, GetTaskEntity>> addNewTask(AddTaskParams task);

  Future<Either<Failure, GetTaskEntity>> deleteTask(DeleteTaskParams id);

  Future<Either<Failure, GetTaskEntity>> updateTask(UpdateTaskParams task);

  Future<Either<Failure, GetAllTaskEntity>> syncTask();
}
