import 'package:dartz/dartz.dart';
import 'package:todoapp/core/error/failures.dart';
import 'package:todoapp/core/usecase/usecase.dart';
import 'package:todoapp/features/task/data/models/param/get_all_task_param.dart';


import '../entities/get_all_task_entity.dart';
import '../repositories/task_repository.dart';

class GetAllTaskUsecase implements Usecase<GetAllTaskEntity,GetAllTaskParams> {
  final TaskRepository? taskRepository;

  GetAllTaskUsecase(this.taskRepository);

  @override
  Future<Either<Failure, GetAllTaskEntity>> call(GetAllTaskParams params) async {
    return await taskRepository!.getAllTask(params);
  }
}
