import 'package:baby_monitor/data/local_storage/storage_conts.dart';
import 'package:hive_flutter/adapters.dart';

part 'family_member_storage_model.g.dart';

@HiveType(typeId: StorageConst.family_member_storage_model_key)
class FamilyMemberStorageModel extends HiveObject {
  FamilyMemberStorageModel(
      {this.birdDate,
      this.familyId,
      this.id,
      this.memberName,
      this.memberStatus,
      this.memberSurname,
      this.userId});
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? familyId;
  @HiveField(2)
  String? userId;
  @HiveField(3)
  String? memberName;
  @HiveField(4)
  String? memberSurname;
  @HiveField(5)
  int? memberStatus;
  @HiveField(6)
  DateTime? birdDate;
}
