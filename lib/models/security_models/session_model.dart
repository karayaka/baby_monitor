import 'package:baby_monitor/models/base_models/base_http_model.dart';

class SessionModel extends BaseHttpModel {
  String? id;
  String? name;
  String? lastName;
  String? email;
  String? image;
  DateTime? expiredDate;

  @override
  fromJson(Map<String, dynamic> json) {
    id = json['nameid'];
    name = json['unique_name'];
    lastName = json["family_name"];
    email = json["email"];
    image = json["image"];
    expiredDate = DateTime.fromMillisecondsSinceEpoch(json["exp"] * 1000);
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
