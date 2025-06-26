// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceAdapter extends TypeAdapter<Attendance> {
  @override
  final int typeId = 1;

  @override
  Attendance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attendance(
      childId: fields[0] as int,
      prayerId: fields[1] as int,
      status: fields[2] as int,
      datetime: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Attendance obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.childId)
      ..writeByte(1)
      ..write(obj.prayerId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.datetime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
