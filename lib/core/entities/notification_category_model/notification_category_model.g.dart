// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationCategoryModelAdapter
    extends TypeAdapter<NotificationCategoryModel> {
  @override
  final int typeId = 0;

  @override
  NotificationCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationCategoryModel(
      name: fields[0] as String,
      langCode: fields[1] as String,
      isActive: fields[2] as bool,
      catId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationCategoryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.langCode)
      ..writeByte(2)
      ..write(obj.isActive)
      ..writeByte(3)
      ..write(obj.catId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
