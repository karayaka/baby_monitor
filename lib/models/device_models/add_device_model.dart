import 'package:baby_monitor/models/base_models/base_http_model.dart';

class AddDeviceModel extends BaseHttpModel {
  String? familyID;
  String? familyName;
  String? deviceBrand;
  String? deviceName;
  String? deviceToken;
  String? fcmToken;

  AddDeviceModel(
      {this.deviceBrand,
      this.deviceName,
      this.deviceToken,
      this.familyID,
      this.familyName,
      this.fcmToken});

  @override
  fromJson(Map<String, dynamic> map) {
    familyID = map["familyID"];
    familyName = map["familyName"];
    deviceBrand = map["deviceBrand"];
    deviceName = map["deviceName"];
    deviceToken = map["deviceToken"];
    fcmToken = map["fcmToken"];
  }

  @override
  Map<String, dynamic> toJson() => {
        "familyID": familyID,
        "familyName": familyName,
        "deviceBrand": deviceBrand,
        "deviceName": deviceName,
        "deviceToken": deviceToken,
        "fcmToken": fcmToken
      };
}
