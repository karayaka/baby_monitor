// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_policy_storage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrivacyPolicyStorageModelAdapter
    extends TypeAdapter<PrivacyPolicyStorageModel> {
  @override
  final int typeId = 5;

  @override
  PrivacyPolicyStorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrivacyPolicyStorageModel()
      ..isAcceptance = fields[0] as bool?
      ..acceptanceDate = fields[1] as DateTime?
      ..versione = fields[2] as int?;
  }

  @override
  void write(BinaryWriter writer, PrivacyPolicyStorageModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isAcceptance)
      ..writeByte(1)
      ..write(obj.acceptanceDate)
      ..writeByte(2)
      ..write(obj.versione);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivacyPolicyStorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
