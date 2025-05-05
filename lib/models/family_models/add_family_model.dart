import 'package:baby_monitor/models/base_models/base_http_model.dart';

class AddFamilyModel extends BaseHttpModel {
  String? name;
  AddFamilyModel({this.name});
  @override
  fromJson(Map<String, dynamic> map) => AddFamilyModel(name: map["name"]);

  @override
  Map<String, dynamic> toJson() => {"name": name};
}
