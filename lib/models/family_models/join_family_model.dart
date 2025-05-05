import 'package:baby_monitor/models/base_models/base_http_model.dart';

class JoinFamilyModel extends BaseHttpModel {
  String? id;
  JoinFamilyModel({this.id});
  @override
  fromJson(Map<String, dynamic> map) => JoinFamilyModel(id: map["id"]);

  @override
  Map<String, dynamic> toJson() => {"id": id};
}
