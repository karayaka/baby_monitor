import 'package:baby_monitor/data/local_storage/storage_conts.dart';
import 'package:hive_flutter/adapters.dart';

part 'device_storage_model.g.dart';

@HiveType(typeId: StorageConst.device_storage_model_key)
class DeviceStorageModel extends HiveObject {
  @HiveField(0)
  String? familyID;
  @HiveField(1)
  String? familyName;
  @HiveField(2)
  String? deviceBrand;
  @HiveField(3)
  String? deviceName;
  @HiveField(4)
  String? deviceToken;
  @HiveField(5)
  String? fcmToken;
  @HiveField(6)
  String? deviceId;
  @HiveField(7)
  String? sd;
  @HiveField(8)
  String? iceCandidate;
  @HiveField(9)
  bool isThisDevice = false;
  @HiveField(10)
  int? streamStatus;
  @HiveField(11)
  String? userID;
  @HiveField(12)
  String? userName;
  @HiveField(13)
  String? userSurname;

  DeviceStorageModel({
    this.familyID,
    this.familyName,
    this.deviceBrand,
    this.deviceName,
    this.deviceToken,
    this.deviceId,
    this.fcmToken,
    this.userName,
    this.userSurname,
    this.userID,
    this.iceCandidate,
    this.sd,
    this.streamStatus,
    this.isThisDevice = false,
  });
}
