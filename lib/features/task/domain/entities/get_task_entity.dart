import 'package:equatable/equatable.dart';

class GetTaskEntity extends Equatable {
  int? id;

  String? todo;

  bool? completed;

  int? userId;

  GetTaskEntity({this.id, this.todo, this.completed, this.userId});

  @override
  List<Object?> get props => [id, todo, completed, userId];
}
