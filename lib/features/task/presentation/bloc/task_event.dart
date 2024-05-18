part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class ResetBlocEvent extends TaskEvent {
  // final String username;

  ResetBlocEvent(// this.username
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        // username
      ];
}

class GetTaskByIDEvent extends TaskEvent {
  final GetTaskByIDParams params;

  GetTaskByIDEvent({required this.params});

  @override
  // TODO: implement props
  List<Object?> get props => [
        // username
      ];
}

class GetAllTaskEvent extends TaskEvent {
  final GetAllTaskParams params;

  GetAllTaskEvent({
    required this.params,
  });

  @override
  // Task: implement props
  List<Object?> get props => [
        // username
      ];
}

class AddNewTaskEvent extends TaskEvent {
  final AddTaskParams addTaskParams;

  AddNewTaskEvent({required this.addTaskParams});

  @override
  // TODO: implement props
  List<Object?> get props => [addTaskParams];
}

class DeleteTaskEvent extends TaskEvent {
  final DeleteTaskParams params;

  DeleteTaskEvent({required this.params});

  @override
  // TODO: implement props
  List<Object?> get props => [params];
}

class UpdateTaskEvent extends TaskEvent {
  final UpdateTaskParams updateTaskParams;

  UpdateTaskEvent(this.updateTaskParams);

  @override
  // TODO: implement props
  List<Object?> get props => [updateTaskParams];
}
