import 'package:baby_monitor/data/local_storage/base_db_manager.dart';
import 'package:baby_monitor/data/local_storage/storage_conts.dart';
import 'package:baby_monitor/data/local_storage/storage_models/device_storage_model.dart';
import 'package:hive_flutter/adapters.dart';

class DeviceDbManager extends BaseDbManager<DeviceStorageModel> {
  DeviceDbManager() : super(StorageConst.device_storage_model_name);

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(StorageConst.device_storage_model_key)) {
      Hive.registerAdapter(DeviceStorageModelAdapter());
    }
  }

  Future<int?> addOrUpdateDevice(DeviceStorageModel model) async {
    try {
      return await addItem(model);
    } catch (e) {
      rethrow;
    }
  }
}
