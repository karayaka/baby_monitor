import 'package:baby_monitor/models/base_models/base_http_model.dart';

class RememberMeModel extends BaseHttpModel {
  String email;
  String? password;
  int loginType;
  RememberMeModel({this.email = "", this.loginType = 0, this.password});
  @override
  fromJson(Map<String, dynamic> map) {
    email = map['email'];
    password = map['password'];
    loginType = map['loginType'];
  }

  @override
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "loginType": loginType,
      };
}
