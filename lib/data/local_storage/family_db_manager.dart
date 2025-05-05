import 'package:baby_monitor/data/local_storage/base_db_manager.dart';
import 'package:baby_monitor/data/local_storage/storage_conts.dart';
import 'package:baby_monitor/data/local_storage/storage_models/family_member_storage_model.dart';
import 'package:baby_monitor/data/local_storage/storage_models/family_storage_model.dart';
import 'package:baby_monitor/models/family_models/family_model.dart';
import 'package:hive_flutter/adapters.dart';

class FamilyDbManager extends BaseDbManager<FamilyStorageModel> {
  FamilyDbManager() : super(StorageConst.family_storage_model_name);

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(StorageConst.family_storage_model_key)) {
      Hive.registerAdapter(FamilyStorageModelAdapter());
    }
    if (!Hive.isAdapterRegistered(
        StorageConst.family_member_storage_model_key)) {
      Hive.registerAdapter(FamilyMemberStorageModelAdapter());
    }
  }

  Future addOrUpdateFamily(FamilyModel model) async {
    try {
      await clearAll();
      await addItem(model.toFamilyStorageModel());
    } catch (e) {
      rethrow;
    }
  }
}
