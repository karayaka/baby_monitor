// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_storage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FamilyStorageModelAdapter extends TypeAdapter<FamilyStorageModel> {
  @override
  final int typeId = 2;

  @override
  FamilyStorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FamilyStorageModel()
      ..familyId = fields[0] as String?
      ..familyName = fields[1] as String?
      ..members = (fields[2] as List?)?.cast<FamilyMemberStorageModel>();
  }

  @override
  void write(BinaryWriter writer, FamilyStorageModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.familyId)
      ..writeByte(1)
      ..write(obj.familyName)
      ..writeByte(2)
      ..write(obj.members);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamilyStorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
