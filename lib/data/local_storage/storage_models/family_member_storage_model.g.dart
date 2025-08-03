// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member_storage_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FamilyMemberStorageModelAdapter
    extends TypeAdapter<FamilyMemberStorageModel> {
  @override
  final int typeId = 3;

  @override
  FamilyMemberStorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FamilyMemberStorageModel(
      birdDate: fields[6] as DateTime?,
      familyId: fields[1] as String?,
      id: fields[0] as String?,
      memberName: fields[3] as String?,
      memberStatus: fields[5] as int?,
      memberSurname: fields[4] as String?,
      userId: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FamilyMemberStorageModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.familyId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.memberName)
      ..writeByte(4)
      ..write(obj.memberSurname)
      ..writeByte(5)
      ..write(obj.memberStatus)
      ..writeByte(6)
      ..write(obj.birdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamilyMemberStorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
