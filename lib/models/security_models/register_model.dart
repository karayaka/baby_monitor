import 'package:baby_monitor/models/base_models/base_http_model.dart';
import 'package:baby_monitor/models/security_models/remember_me_model.dart';

class RegisterModel extends BaseHttpModel {
  String? email;
  String? password;
  String? googleId;
  int? loginType;
  String? name;
  String? surname;
  String? image;
  @override
  fromJson(Map<String, dynamic> map) {
    email = map['email'];
    password = map['password'];
    googleId = map['googleId'];
    loginType = map['loginType'];
    name = map['name'];
    surname = map['surname'];
    image = map['image'];
  }

  @override
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "googleId": googleId,
        "loginType": loginType,
        "name": name,
        "surname": surname,
        "image": image
      };
  RememberMeModel toRememberMeModel() => RememberMeModel(
      email: email ?? "", password: password ?? "", loginType: loginType ?? 0);
}
