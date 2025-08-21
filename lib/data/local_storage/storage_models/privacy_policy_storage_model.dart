import 'package:baby_monitor/data/local_storage/storage_conts.dart';
import 'package:hive_flutter/adapters.dart';

part 'privacy_policy_storage_model.g.dart';

@HiveType(typeId: StorageConst.privacy_policy_model_key)
class PrivacyPolicyStorageModel extends HiveObject {
  PrivacyPolicyStorageModel({
    this.isAcceptance,
    this.acceptanceDate,
    this.versione,
  });
  @HiveField(0)
  bool? isAcceptance;
  @HiveField(1)
  DateTime? acceptanceDate;
  @HiveField(2)
  int? versione;
}
