import 'package:baby_monitor/models/base_models/base_http_model.dart';

class ProfileModel extends BaseHttpModel {
  String? id;
  String? name;
  String? email;
  String? surname;
  String? imageUrl;
  bool? isMailConfirm;
  int? loginType;

  ProfileModel({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.imageUrl,
    this.isMailConfirm,
    this.loginType,
  });

  @override
  fromJson(Map<String, dynamic> map) => ProfileModel(
    id: map["id"],
    name: map["name"],
    surname: map["surname"],
    imageUrl: map["imageUrl"],
    isMailConfirm: map["isMailConfirm"],
    email: map["email"],
    loginType: map["loginType"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "imageUrl": imageUrl,
    "isMailConfirm": isMailConfirm,
    "loginType": loginType,
    "email": email,
  };
}
