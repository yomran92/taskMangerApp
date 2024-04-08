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
  final List<GetTaskEntity> tasks;

  // final String username;

  GetAllTaskLoadedState(
    this.tasks,
    // this.username,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
        // tasks,
        // this.username,
      ];
}

class AddNewTaskState extends TaskState {
  final TaskModel  task;

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
  final String id;

  DeleteTaskState(
    this.id,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
      ];
}

class UpdateTaskState extends TaskState {
  final TaskModel taskModel;

  UpdateTaskState(this.taskModel);

  @override
  // TODO: implement props
  List<Object?> get props => [taskModel];
}
