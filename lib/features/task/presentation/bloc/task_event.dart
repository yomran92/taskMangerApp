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

class LoadTaskEvent extends TaskEvent {
  // final String username;

  LoadTaskEvent(// this.username
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        // username
      ];
}

class SyncTaskEvent extends TaskEvent {
  SyncTaskEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [
        // username
      ];
}

class GetAllTaskEvent extends TaskEvent {
  final int? pageNumber;

  GetAllTaskEvent({required  this.pageNumber
  });

  @override
  // Task: implement props
  List<Object?> get props => [
        // username
      ];
}

class AddNewTaskEvent extends TaskEvent {
  final TaskModel task;

  AddNewTaskEvent(this.task);

  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  DeleteTaskEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class UpdateTaskEvent extends TaskEvent {
  final TaskModel taskModel;

  UpdateTaskEvent(this.taskModel);

  @override
  // TODO: implement props
  List<Object?> get props => [taskModel];
}
