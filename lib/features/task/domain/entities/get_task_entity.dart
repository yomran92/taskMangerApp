import 'package:equatable/equatable.dart';

class GetTaskEntity extends Equatable {
  final String? id;

  final String? title;

  final String? content;
  final bool? synced;

  GetTaskEntity(
      {required this.id,
      required this.title,
      required this.content,
      required this.synced});

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        synced,
      ];
}
