import 'package:baby_monitor/data/local_storage/base_db_manager.dart';
import 'package:baby_monitor/data/local_storage/storage_conts.dart';
import 'package:baby_monitor/data/local_storage/storage_models/privacy_policy_storage_model.dart';
import 'package:hive_flutter/adapters.dart';

class PrivacyPolicyDbManager extends BaseDbManager<PrivacyPolicyStorageModel> {
  PrivacyPolicyDbManager() : super(StorageConst.privacy_policy_model_name);

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(StorageConst.privacy_policy_model_key)) {
      Hive.registerAdapter(PrivacyPolicyStorageModelAdapter());
    }
  }

  Future setPrivacyPolicyData({int versione = 1}) async {
    await init();
    await clearAll();
    await addItem(
      PrivacyPolicyStorageModel(
        isAcceptance: true,
        acceptanceDate: DateTime.now(),
        versione: versione,
      ),
    );
  }

  Future<PrivacyPolicyStorageModel?> getPrivacyPolicy() async {
    await init();
    return getFist();
  }
}
