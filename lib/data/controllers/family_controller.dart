import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/family_repoistory.dart';
import 'package:baby_monitor/models/family_models/add_family_model.dart';
import 'package:baby_monitor/models/family_models/family_model.dart';
import 'package:baby_monitor/models/family_models/join_family_model.dart';
import 'package:get/get.dart';

class FamilyController extends BaseController {
  late FamilyRepoistory _familyRepoistory;
  late AddFamilyModel model;
  var familyModel = FamilyModel().obs;
  var familyLoading = false.obs;
  var hasFamily = false.obs;
  var addFamilyLoading = false.obs;
  var addFamilyModel = AddFamilyModel();
  var joinFamilyLoading = false.obs;

  FamilyController() {
    _familyRepoistory = Get.find();
    getFamily();
  }
//TODO get family tamalanadı join family ve leave famly şlemleri yapılıp test edilecek ve doğım günü ekleme işlemelri
  Future getFamily() async {
    try {
      var family = await _familyRepoistory.getDbFamily();
      if (family != null) {
        familyModel.value = family;
      }

      familyLoading.value = true;
      var fml = prepareServiceModel<FamilyModel>(
          await _familyRepoistory.getFamily(getSession()?.id ?? ""));

      if (fml != null) {
        familyModel.value = fml;
        await _familyRepoistory.addOrUpdateFamily(fml);
      } else {
        await _familyRepoistory.clearFamily();
        familyModel.value = FamilyModel();
      }
      familyLoading.value = false;
    } catch (e) {
      familyLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future addFamily() async {
    addFamilyLoading.value = true;
    prepareServiceModel<String>(
        await _familyRepoistory.addFamily(addFamilyModel));
    Get.back();
    addFamilyLoading.value = false;
    succesMessage("Aile Ekleme İşlemi Bşarılı");
    getFamily();
    try {} catch (e) {
      addFamilyLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future leaveFamily(String memberId) async {
    try {
      familyLoading.value = true;

      prepareServiceModel<String>(
          await _familyRepoistory.leaveFamily(memberId));
      familyLoading.value = false;
      Get.back();
      succesMessage("Aileden Ayrılma İşlemi Bşarılı");
      getFamily();
    } catch (e) {
      addFamilyLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future joinFamily(String familyId) async {
    try {
      joinFamilyLoading.value = true;
      prepareServiceModel<String>(
          await _familyRepoistory.joinFamily(JoinFamilyModel(id: familyId)));
      joinFamilyLoading.value = false;
      getFamily();
      Get.back();
    } catch (e) {
      joinFamilyLoading.value = false;
      exceptionHandle(e);
    }
  }

  bool canLeaveFromMaily(String userID) => userID == getSession()?.id;
}
