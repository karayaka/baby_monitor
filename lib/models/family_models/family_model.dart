import 'package:baby_monitor/data/local_storage/storage_models/family_member_storage_model.dart';
import 'package:baby_monitor/data/local_storage/storage_models/family_storage_model.dart';
import 'package:baby_monitor/models/base_models/base_http_model.dart';
import 'package:baby_monitor/models/family_models/family_member_model.dart';

class FamilyModel extends BaseHttpModel {
  String? id;
  String? name;
  List<FamilyMemberModel>? members;
  FamilyModel({this.id, this.members, this.name});
  @override
  fromJson(Map<String, dynamic> map) {
    var family = FamilyModel(
      id: map["id"],
      name: map["name"],
    );
    if (map["members"] != null) {
      family.members = [];
      map['members'].forEach((v) {
        family.members!.add(FamilyMemberModel().fromJson(v));
      });
    }
    return family;
  }

  @override
  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    if (members != null) {
      data["members"] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  FamilyStorageModel toFamilyStorageModel() {
    try {
      var family = FamilyStorageModel(
        familyId: id,
        familyName: name,
      );
      if (members != null) {
        family.members = members!
            .map((v) => FamilyMemberStorageModel(
                  id: v.id,
                  familyId: v.familyID,
                  memberName: v.memberName,
                  memberSurname: v.memberSurname,
                  memberStatus: v.memberStatus,
                  userId: v.userID,
                  birdDate: v.birdDate,
                ))
            .toList();
      }
      return family;
    } catch (e) {
      rethrow;
    }
  }
}
