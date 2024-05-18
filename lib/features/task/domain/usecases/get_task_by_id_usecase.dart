import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/param/get_task_by_id_param.dart';
import '../entities/get_task_entity.dart';
import '../repositories/task_repository.dart';

class GetTaskByIDUsecase implements Usecase<GetTaskEntity, GetTaskByIDParams> {
  final TaskRepository? taskRepository;

  GetTaskByIDUsecase(this.taskRepository);

  @override
  Future<Either<ErrorEntity, GetTaskEntity>> call(
      GetTaskByIDParams params) async {
    return await taskRepository!.getTaskById(params);
  }
}
