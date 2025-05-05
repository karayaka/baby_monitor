import 'package:baby_monitor/models/base_models/base_http_model.dart';
import 'package:baby_monitor/models/security_models/remember_me_model.dart';

class LoginModel extends BaseHttpModel {
  String? email;
  String? password;
  int? loginType;

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

  RememberMeModel toRememberMeModel() => RememberMeModel(
      email: email ?? "", password: password ?? "", loginType: loginType ?? 0);
}
