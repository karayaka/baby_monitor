import 'package:baby_monitor/data/local_storage/storage_conts.dart';
import 'package:baby_monitor/data/local_storage/storage_models/family_member_storage_model.dart';
import 'package:hive_flutter/adapters.dart';

part 'family_storage_model.g.dart';

@HiveType(typeId: StorageConst.family_storage_model_key)
class FamilyStorageModel extends HiveObject {
  FamilyStorageModel({this.familyId, this.familyName, this.members});

  @HiveField(0)
  String? familyId;
  @HiveField(1)
  String? familyName;
  @HiveField(2)
  List<FamilyMemberStorageModel>? members;
}
