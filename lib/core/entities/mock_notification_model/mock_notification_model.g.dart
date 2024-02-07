// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MockNotificationModelAdapter extends TypeAdapter<MockNotificationModel> {
  @override
  final int typeId = 0;

  @override
  MockNotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MockNotificationModel(
      id: fields[0] as String,
      userId: fields[1] as int,
      notifyType: fields[2] as int,
      notifyCategory: fields[3] as int,
      title: fields[4] as String,
      content: fields[5] as String,
      createdAt: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MockNotificationModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.notifyType)
      ..writeByte(3)
      ..write(obj.notifyCategory)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.content)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MockNotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
