import 'package:dartz/dartz.dart';
import 'package:todoapp/features/task/data/models/param/delete_task_param.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/models/param/add_new_task_param.dart';
import '../../data/models/param/get_all_task_param.dart';
import '../../data/models/param/get_task_by_id_param.dart';
import '../../data/models/param/update_task_param.dart';
import '../entities/get_all_task_entity.dart';
import '../entities/get_task_entity.dart';

abstract class TaskRepository {
  Future<Either<ErrorEntity, GetAllTaskEntity>> getAllTask(
      GetAllTaskParams params);

  Future<Either<ErrorEntity, GetTaskEntity>> addNewTask(AddTaskParams task);

  Future<Either<ErrorEntity, GetTaskEntity>> deleteTask(DeleteTaskParams id);

  Future<Either<ErrorEntity, GetTaskEntity>> updateTask(UpdateTaskParams task);

  Future<Either<ErrorEntity, GetTaskEntity>> getTaskById(
      GetTaskByIDParams taskId);
}
