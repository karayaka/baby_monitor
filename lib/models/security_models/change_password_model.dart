import 'package:baby_monitor/models/base_models/base_http_model.dart';

class ChangePasswordModel extends BaseHttpModel {
  String? oldPassword;
  String? newPassword;
  String? newPasswordConfirme;

  ChangePasswordModel({
    this.newPassword,
    this.oldPassword,
    this.newPasswordConfirme,
  });
  @override
  fromJson(Map<String, dynamic> map) => ChangePasswordModel(
    newPassword: map["newPassword"],
    oldPassword: map["oldPassword"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "newPassword": newPassword,
    "oldPassword": oldPassword,
  };
}
