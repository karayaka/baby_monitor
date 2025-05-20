import 'package:baby_monitor/models/base_models/base_http_model.dart';

class RefreshFcmTokenModel extends BaseHttpModel {
  String? deviceId;
  String? fcmToken;
  RefreshFcmTokenModel({this.deviceId, this.fcmToken});
  @override
  fromJson(Map<String, dynamic> map) => RefreshFcmTokenModel(
    deviceId: map["deviceID"],
    fcmToken: map["fcmToken"],
  );

  @override
  Map<String, dynamic> toJson() => {"deviceID": deviceId, "fcmToken": fcmToken};
}
