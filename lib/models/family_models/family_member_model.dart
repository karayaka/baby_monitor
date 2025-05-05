import 'package:baby_monitor/data/local_storage/storage_models/family_member_storage_model.dart';
import 'package:baby_monitor/models/base_models/base_http_model.dart';

class FamilyMemberModel extends BaseHttpModel {
  String? id;
  String? familyID;
  String? userID;
  String? memberName;
  String? memberSurname;
  int? memberStatus;
  DateTime? birdDate;

  FamilyMemberModel(
      {this.birdDate,
      this.familyID,
      this.id,
      this.memberName,
      this.memberStatus,
      this.memberSurname,
      this.userID});

  @override
  fromJson(Map<String, dynamic> map) => FamilyMemberModel(
      id: map["id"],
      familyID: map["familyID"],
      userID: map["userID"],
      memberName: map["memberName"],
      memberSurname: map["memberSurname"],
      memberStatus: map["memberStatus"],
      birdDate: map["birdDate"]);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "birdDate": birdDate,
        "familyID": familyID,
        "memberName": memberName,
        "memberStatus": memberStatus,
        "memberSurname": memberSurname,
        "userID": userID
      };
  FamilyMemberModel toFamilyMemberModel(FamilyMemberStorageModel model) =>
      FamilyMemberModel(
          id: model.id,
          familyID: model.familyId,
          birdDate: model.birdDate,
          memberName: model.memberName,
          memberSurname: model.memberSurname,
          memberStatus: model.memberStatus,
          userID: model.userId);
}
