part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskError extends TaskState {
  String message;

  TaskError({required this.message});

  @override
  List<Object> get props => [];
}

class GetAllTaskLoadedState extends TaskState {
  final List<GetTaskEntity>? tasks;
  final int? total;
  final int? skip;
  final int? limit;

  GetAllTaskLoadedState({this.tasks, this.skip, this.limit, this.total}
      // this.username,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        // tasks,
        // this.username,
      ];
}

class GetTaskByIDLoadedState extends TaskState {
  final GetTaskEntity? task;

  GetTaskByIDLoadedState({this.task});

  @override
  // TODO: implement props
  List<Object?> get props => [
        task,
        // this.username,
      ];
}

class AddNewTaskState extends TaskState {
  final GetTaskEntity task;

  AddNewTaskState(
    this.task,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
        task,
        // this.username,
      ];
}

class DeleteTaskState extends TaskState {
  final GetTaskEntity taskModel;

  DeleteTaskState(
    this.taskModel,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
        taskModel,
      ];
}

class UpdateTaskState extends TaskState {
  final GetTaskEntity taskModel;

  UpdateTaskState(this.taskModel);

  @override
  // TODO: implement props
  List<Object?> get props => [taskModel];
}
