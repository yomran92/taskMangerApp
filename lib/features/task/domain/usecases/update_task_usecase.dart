import 'package:dartz/dartz.dart';
import 'package:todoapp/core/error/failures.dart';
import 'package:todoapp/core/usecase/usecase.dart';

import '../../data/models/param/update_task_param.dart';
import '../entities/get_task_entity.dart';
import '../repositories/task_repository.dart';


class UpdateTaskUsecase implements Usecase<GetTaskEntity, UpdateTaskParams> {
  final TaskRepository? taskRepository;

  UpdateTaskUsecase(this.taskRepository);

  @override
  Future<Either<Failure, GetTaskEntity>> call(UpdateTaskParams params) async {
    return await taskRepository!.updateTask(params);
  }
}
