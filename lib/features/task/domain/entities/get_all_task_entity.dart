import 'package:equatable/equatable.dart';

import 'get_task_entity.dart';

class GetAllTaskEntity extends Equatable {
  final List<GetTaskEntity>? taskList;

  GetAllTaskEntity({required this.taskList});

  @override
  List<Object?> get props => [taskList];
}
