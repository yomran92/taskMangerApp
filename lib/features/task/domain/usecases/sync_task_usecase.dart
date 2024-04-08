import 'package:dartz/dartz.dart';


import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/get_all_task_entity.dart';
import '../repositories/task_repository.dart';

class SyncTaskUsecase implements UseCaseWithoutParams<GetAllTaskEntity> {
  final TaskRepository? taskRepository;

  SyncTaskUsecase(this.taskRepository);

  @override
  Future<Either<Failure, GetAllTaskEntity>> call() async {
    return await taskRepository!.syncTask();
  }
}
