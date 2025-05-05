import 'package:baby_monitor/models/base_models/base_http_model.dart';

class ResetPasswordModel extends BaseHttpModel {
  String? email;
  @override
  fromJson(Map<String, dynamic> map) {
    email = map['email'];
  }

  @override
  Map<String, dynamic> toJson() => {"email": email};
}
