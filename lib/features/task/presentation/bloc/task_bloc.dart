import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/features/task/data/models/param/get_all_task_param.dart';
import 'package:todoapp/features/task/data/models/param/get_task_by_id_param.dart';
import 'package:todoapp/service_locator.dart';

import '../../data/models/param/add_new_task_param.dart';
import '../../data/models/param/delete_task_param.dart';
import '../../data/models/param/update_task_param.dart';
import '../../domain/entities/get_task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/add_new_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/get_all_task_usecase.dart';
import '../../domain/usecases/get_task_by_id_usecase.dart';
import '../../domain/usecases/update_task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(// this._taskervice
      )
      : super(TaskInitial()) {
    on<GetAllTaskEvent>((event, emit) async {
      emit(TaskLoading());

      var res =
          await GetAllTaskUsecase(sl<TaskRepository>()).call(event.params);
      emit(res.fold(
          (l) => TaskError(message: l.errorMessage ?? ''),
          (r) => GetAllTaskLoadedState(
              skip: r.skip, limit: r.limit, tasks: r.todos, total: r.total)));
    });
    on<GetTaskByIDEvent>((event, emit) async {
      emit(TaskLoading());

      var res =
          await GetTaskByIDUsecase(sl<TaskRepository>()).call(event.params);
      emit(res.fold(
          (l) => TaskError(message: l.errorMessage ?? ''),
          (r) => GetTaskByIDLoadedState(
                  task: GetTaskEntity(
                id: r.id,
                todo: r.todo,
                completed: r.completed,
                userId: r.userId,
              ))));
    });
    on<ResetBlocEvent>((event, emit) async {
      emit(TaskInitial());
    });

    on<AddNewTaskEvent>((event, emit) async {
      emit(TaskLoading());

      var res = await AddNewTaskUsecase(sl<TaskRepository>())
          .call(event.addTaskParams);
      emit(res.fold(
          (l) => TaskError(message: l.errorMessage ?? ''),
          (r) => AddNewTaskState(GetTaskEntity(
                id: r.id,
                todo: r.todo,
                completed: r.completed,
                userId: r.userId,
              ))));
    });
    on<DeleteTaskEvent>((event, emit) async {
      emit(TaskLoading());

      var res =
          await DeleteTaskUsecase(sl<TaskRepository>()).call(event.params);
      emit(res.fold((l) => TaskError(message: l.errorMessage ?? ''),
          (r) => DeleteTaskState(r!)));
    });
    on<UpdateTaskEvent>((event, emit) async {
      emit(TaskLoading());

      var res = await UpdateTaskUsecase(sl<TaskRepository>()).call(
        event.updateTaskParams,
      );
      emit(res.fold((l) => TaskError(message: l.errorMessage ?? ''),
          (r) => UpdateTaskState(r)));
    });
  }
}
