import 'package:dartz/dartz.dart';
import 'package:todoapp/core/usecase/usecase.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/models/param/add_new_task_param.dart';
import '../entities/get_task_entity.dart';
import '../repositories/task_repository.dart';

class AddNewTaskUsecase implements Usecase<GetTaskEntity, AddTaskParams> {
  final TaskRepository? taskRepository;

  AddNewTaskUsecase(this.taskRepository);

  @override
  Future<Either<ErrorEntity, GetTaskEntity>> call(AddTaskParams params) async {
    return await taskRepository!.addNewTask(params);
  }
}
