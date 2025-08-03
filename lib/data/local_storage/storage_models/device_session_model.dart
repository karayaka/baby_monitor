import 'package:baby_monitor/data/local_storage/storage_conts.dart';
import 'package:hive_flutter/adapters.dart';

part 'device_session_model.g.dart';

@HiveType(typeId: StorageConst.device_storage_model_key)
class DeviceSessionModel extends HiveObject {
  @HiveField(0)
  String? deviceId;
  @HiveField(1)
  String? deviceName;
}
