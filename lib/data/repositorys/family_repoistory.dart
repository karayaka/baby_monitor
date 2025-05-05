import 'package:baby_monitor/data/local_storage/family_db_manager.dart';
import 'package:baby_monitor/data/repositorys/base_repository.dart';
import 'package:baby_monitor/data/services/http_service.dart';
import 'package:baby_monitor/models/base_models/base_result.dart';
import 'package:baby_monitor/models/family_models/add_family_model.dart';
import 'package:baby_monitor/models/family_models/family_member_model.dart';
import 'package:baby_monitor/models/family_models/family_model.dart';
import 'package:baby_monitor/models/family_models/join_family_model.dart';

class FamilyRepoistory extends BaseRepository {
  late HttpService _service;
  late FamilyDbManager _dbManager;
  FamilyRepoistory() {
    _service = HttpService.instance!;
    _dbManager = FamilyDbManager();
  }

  Future<BaseResult> getFamily(String userId) async {
    try {
      return await _service.get(
          "family/Family/GetFamilyByUserID/$userId", FamilyModel(),
          token: (getToken() ?? ""));
    } catch (e) {
      rethrow;
    }
  }

  Future<FamilyModel?> getDbFamily() async {
    var family = FamilyModel();
    await _dbManager.init();
    var fml = _dbManager.getFist();
    if (fml != null) {
      family.id = fml.familyId;
      family.name = fml.familyName;
      if (fml.members != null) {
        family.members = [];
        for (var item in fml.members!) {
          var member = FamilyMemberModel(
            id: item.id,
            memberName: item.memberName,
            memberSurname: item.memberSurname,
            userID: item.userId,
            birdDate: item.birdDate,
            familyID: item.familyId,
            memberStatus: item.memberStatus,
          );
          family.members!.add(member);
        }
      }
      return family;
    }
    return null;
  }

  Future addOrUpdateFamily(FamilyModel model) async {
    try {
      await _dbManager.init();
      await _dbManager.addOrUpdateFamily(model);
    } catch (e) {
      rethrow;
    }
  }

  Future clearFamily() async {
    try {
      await _dbManager.init();
      await _dbManager.clearAll();
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> addFamily(AddFamilyModel model) async {
    try {
      return await _service.post("family/Family/AddFamily", null, model,
          token: getToken());
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> joinFamily(JoinFamilyModel model) async {
    try {
      return await _service.post("family/Family/JoinFamily", null, model,
          token: getToken());
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> leaveFamily(String memberId) async {
    try {
      return await _service.get("family/Family/LeaveFamily/$memberId", null,
          token: getToken() ?? "");
    } catch (e) {
      rethrow;
    }
  }
}
