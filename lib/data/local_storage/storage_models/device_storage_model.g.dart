// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_storage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeviceStorageModelAdapter extends TypeAdapter<DeviceStorageModel> {
  @override
  final int typeId = 1;

  @override
  DeviceStorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceStorageModel(
      familyID: fields[0] as String?,
      familyName: fields[1] as String?,
      deviceBrand: fields[2] as String?,
      deviceName: fields[3] as String?,
      deviceToken: fields[4] as String?,
      deviceId: fields[6] as String?,
      fcmToken: fields[5] as String?,
      iceCandidate: fields[8] as String?,
      sd: fields[7] as String?,
      streamStatus: fields[10] as int?,
      isThisDevice: fields[9] as bool,
    )
      ..userID = fields[11] as String?
      ..userName = fields[12] as String?
      ..userSurname = fields[13] as String?;
  }

  @override
  void write(BinaryWriter writer, DeviceStorageModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.familyID)
      ..writeByte(1)
      ..write(obj.familyName)
      ..writeByte(2)
      ..write(obj.deviceBrand)
      ..writeByte(3)
      ..write(obj.deviceName)
      ..writeByte(4)
      ..write(obj.deviceToken)
      ..writeByte(5)
      ..write(obj.fcmToken)
      ..writeByte(6)
      ..write(obj.deviceId)
      ..writeByte(7)
      ..write(obj.sd)
      ..writeByte(8)
      ..write(obj.iceCandidate)
      ..writeByte(9)
      ..write(obj.isThisDevice)
      ..writeByte(10)
      ..write(obj.streamStatus)
      ..writeByte(11)
      ..write(obj.userID)
      ..writeByte(12)
      ..write(obj.userName)
      ..writeByte(13)
      ..write(obj.userSurname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceStorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
