import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/local_storage/privacy_policy_db_manager.dart';
import 'package:baby_monitor/data/local_storage/storage_models/privacy_policy_storage_model.dart';
import 'package:baby_monitor/data/repositorys/security_repository.dart';
import 'package:baby_monitor/models/profile_models/profile_model.dart';
import 'package:baby_monitor/models/security_models/change_password_model.dart';
import 'package:baby_monitor/models/security_models/reset_password_model.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends BaseController {
  late SecurityRepository _repository;
  ProfileModel? profile = ProfileModel();
  ChangePasswordModel changePasswordModel = ChangePasswordModel();
  var profileLoading = false.obs;
  var privacyLoading = false.obs;
  var langugeLoading = false.obs;
  var updateProfileLoading = false.obs;
  var hidePassword = false.obs;
  var changePasswordKey = GlobalKey<FormState>();
  late PrivacyPolicyDbManager _policyDbManager;
  late PrivacyPolicyStorageModel? policyStorageModel;

  ProfileController() {
    _repository = Get.find();
    _policyDbManager = PrivacyPolicyDbManager();
    policyStorageModel = PrivacyPolicyStorageModel();
  }
  @override
  onInit() {
    super.onInit();
    getProfile();
    getPolicyModel();
  }

  Future getProfile() async {
    try {
      profileLoading.value = true;
      profile = prepareServiceModel<ProfileModel>(
        await _repository.getProfile(),
      );
      profileLoading.value = false;
    } catch (e) {
      profileLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future getPolicyModel() async {
    try {
      privacyLoading.value = true;
      policyStorageModel = await _policyDbManager.getPrivacyPolicy();
      privacyLoading.value = false;
    } catch (e) {
      privacyLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future updateProfile() async {
    try {
      updateProfileLoading.value = true;
      prepareServiceModel<bool>(await _repository.updateProfile(profile!));
      updateProfileLoading.value = false;
      succesMessage("Profiliniz Güncellendi");
    } catch (e) {
      updateProfileLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future setLanguge(String langugeCode) async {
    try {
      langugeLoading.value = true;
      var locale = ProjectConst.getSelectedLocale(langugeCode);
      final box = GetStorage();
      await Get.updateLocale(locale);
      await box.write(ProjectConst.LANGUAGE_CODE, locale.languageCode);
      langugeLoading.value = false;
    } catch (e) {
      exceptionHandle(e);
      langugeLoading.value = false;
    }
  }

  Future deleteProfile() async {
    try {
      updateProfileLoading.value = true;
      prepareServiceModel<bool>(await _repository.deleteProfile());
      //Başarılı olması halinde çıkış yapılıp sıfırlanıyor
      await removeAllStore();
      succesMessage("Profiliniz Başarı İle Kaldırıldı");
      updateProfileLoading.value = false;
      Get.offAllNamed(RouteConst.security);
    } catch (e) {
      updateProfileLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future confirmEmail() async {
    try {
      if (profile?.isMailConfirm ?? false) {
        return;
      }
      updateProfileLoading.value = true;
      await _repository.sendConfimEmail(
        ResetPasswordModel(email: getSession()?.email ?? ""),
      );
      updateProfileLoading.value = false;
      showConfirmeDialog(
        () {
          Get.back();
        },
        title: "Email Doğrulama",
        message: "Doğrulma Mailiniz Gönderilmiştir Lütfen Kotrol Ediniz",
      );
    } catch (e) {
      updateProfileLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future changePassword() async {
    try {
      if (!changePasswordKey.currentState!.validate()) {
        return;
      }
      updateProfileLoading.value = true;
      changePasswordModel.oldPassword ??= "";
      prepareServiceModel<bool>(
        await _repository.changePassword(changePasswordModel),
      );

      updateProfileLoading.value = false;
      Get.offAllNamed(RouteConst.security);
    } catch (e) {
      updateProfileLoading.value = false;
      exceptionHandle(e);
    }
  }

  Future<void> privacyPage() async {
    if (!await launchUrl(Uri.parse(ProjectConst.privacyUrl()))) {
      throw Exception('Could not launch');
    }
  }
}
