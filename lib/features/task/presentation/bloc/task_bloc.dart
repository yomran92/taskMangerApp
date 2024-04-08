import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/core/error/failures.dart';
import 'package:todoapp/features/task/data/models/param/get_all_task_param.dart';

import 'package:todoapp/service_locator.dart';

import '../../data/models/param/add_new_task_param.dart';
import '../../data/models/param/delete_task_param.dart';
import '../../data/models/param/update_task_param.dart';
import '../../data/models/task_model.dart';
import '../../domain/entities/get_task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/add_new_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/get_all_task_usecase.dart';
import '../../domain/usecases/sync_task_usecase.dart';
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

      var res = await GetAllTaskUsecase(sl<TaskRepository>()).call(GetAllTaskParams(
          body: GetAllTaskParamsBody(pageNumber: event.pageNumber)));
      emit(res.fold((l) =>
          TaskError(message: _mapFailureToMessage(l)),
          (r) => GetAllTaskLoadedState(r.taskList!)));
    });
    on<ResetBlocEvent>((event, emit) async {
      emit(TaskInitial());
    });
    on<SyncTaskEvent>((event, emit) async {
      var res = await SyncTaskUsecase(sl<TaskRepository>()).call();

      emit(res.fold((l) => TaskError(message: _mapFailureToMessage(l)),
          (r) => GetAllTaskLoadedState(r.taskList!)));
    });
    on<AddNewTaskEvent>((event, emit) async {
      emit(TaskLoading());

      var res = await AddNewTaskUsecase(sl<TaskRepository>())
          .call(AddTaskParams(body:AddTaskParamsBody(task:   event.task)));
      emit(res.fold(
          (l) => TaskError(message: _mapFailureToMessage(l)),
          (r) => AddNewTaskState(TaskModel(
                id: r.id,
                content: r.content,
                title: r.title,
                synced: r.synced,
              ))));
    });
    on<DeleteTaskEvent>((event, emit) async {
      emit(TaskLoading());

      var res = await DeleteTaskUsecase(sl<TaskRepository>())
          .call(DeleteTaskParams(body:DeleteTaskParamsBody(id:   event.id)));
      emit(res.fold((l) => TaskError(message: _mapFailureToMessage(l)),
          (r) => DeleteTaskState(r.id!)));
    });
    on<UpdateTaskEvent>((event, emit) async {
      emit(TaskLoading());

      var res = await UpdateTaskUsecase(sl<TaskRepository>())
          .call(UpdateTaskParams( body:UpdateTaskParamsBody(task:   event.taskModel)));
      emit(res.fold((l) => TaskError(message: _mapFailureToMessage(l)),
          (r) => UpdateTaskState(event.taskModel)));
    });


  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
