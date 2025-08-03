// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_session_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeviceSessionModelAdapter extends TypeAdapter<DeviceSessionModel> {
  @override
  final int typeId = 1;

  @override
  DeviceSessionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceSessionModel()
      ..deviceId = fields[0] as String?
      ..deviceName = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, DeviceSessionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.deviceId)
      ..writeByte(1)
      ..write(obj.deviceName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceSessionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
