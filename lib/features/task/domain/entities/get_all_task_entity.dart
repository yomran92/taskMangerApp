import 'package:equatable/equatable.dart';

import 'get_task_entity.dart';

class GetAllTaskEntity extends Equatable {
  final List<GetTaskEntity>? todos;

  final int? total;
  final int? skip;
  final int? limit;

  GetAllTaskEntity({this.todos, this.total, this.skip, this.limit});

  @override
  List<Object?> get props => [todos, total, skip, limit];
}
