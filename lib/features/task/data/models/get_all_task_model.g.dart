// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetAllTaskModelAdapter extends TypeAdapter<GetAllTaskModel> {
  @override
  final int typeId = 1;

  @override
  GetAllTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetAllTaskModel(
      taskList: (fields[0] as List?)?.cast<TaskModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, GetAllTaskModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.taskList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetAllTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
