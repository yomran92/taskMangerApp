import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/param/delete_task_param.dart';
import '../entities/get_task_entity.dart';
import '../repositories/task_repository.dart';

class DeleteTaskUsecase implements Usecase<GetTaskEntity, DeleteTaskParams> {
  final TaskRepository? taskRepository;

  DeleteTaskUsecase(this.taskRepository);

  @override
  Future<Either<ErrorEntity, GetTaskEntity>> call(
      DeleteTaskParams params) async {
    return await taskRepository!.deleteTask(params);
  }
}
