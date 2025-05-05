import 'package:baby_monitor/data/local_storage/storage_models/device_storage_model.dart';
import 'package:baby_monitor/models/base_models/base_http_model.dart';

class DeviceListModel extends BaseHttpModel {
  String? id;
  String? userID;
  String? userName;
  String? userSurname;
  String? familyID;
  String? familyName;
  String? deviceBrand;
  String? deviceName;
  String? deviceToken;
  String? sd;
  String? iceCandidate;
  String? fcmToken;
  int? streamStatus;

  DeviceListModel(
      {this.id,
      this.userID,
      this.userName,
      this.userSurname,
      this.familyID,
      this.familyName,
      this.deviceBrand,
      this.deviceName,
      this.deviceToken,
      this.sd,
      this.iceCandidate,
      this.fcmToken,
      this.streamStatus});

  @override
  fromJson(Map<String, dynamic> map) => DeviceListModel(
        id: map["id"],
        userID: map["userID"],
        userName: map["userName"],
        userSurname: map["userSurname"],
        familyID: map["familyID"],
        familyName: map["familyName"],
        deviceBrand: map["deviceBrand"],
        deviceName: map["deviceName"],
        deviceToken: map["deviceToken"],
        sd: map["sd"],
        iceCandidate: map["iceCandidate"],
        fcmToken: map["fcmToken"],
        streamStatus: map["streamStatus"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userID,
        "userName": userName,
        "userSurname": userSurname,
        "familyID": familyID,
        "familyName": familyName,
        "deviceBrand": deviceBrand,
        "deviceName": deviceName,
        "deviceToken": deviceToken,
        "sd": sd,
        "iceCandidate": iceCandidate,
        "fcmToken": fcmToken,
        "streamStatus": streamStatus,
      };

  fromDeviceStorageMoel(DeviceStorageModel? model) => DeviceListModel(
        id: model?.deviceId,
        userID: model?.userID,
        userName: model?.userName,
        userSurname: model?.userSurname,
        familyID: model?.familyID,
        familyName: model?.familyName,
        deviceBrand: model?.deviceBrand,
        deviceName: model?.deviceName,
        deviceToken: model?.deviceToken,
        sd: model?.sd,
        iceCandidate: model?.iceCandidate,
        fcmToken: model?.fcmToken,
        streamStatus: model?.streamStatus,
      );
}
