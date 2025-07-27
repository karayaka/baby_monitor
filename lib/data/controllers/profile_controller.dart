import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/security_repository.dart';
import 'package:baby_monitor/models/profile_models/profile_model.dart';
import 'package:baby_monitor/models/security_models/change_password_model.dart';
import 'package:baby_monitor/models/security_models/reset_password_model.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  late SecurityRepository _repository;
  ProfileModel? profile = ProfileModel();
  ChangePasswordModel changePasswordModel = ChangePasswordModel();
  var profileLoading = false.obs;
  var updateProfileLoading = false.obs;
  var hidePassword = false.obs;
  var changePasswordKey = GlobalKey<FormState>();

  ProfileController() {
    _repository = Get.find();
  }
  @override
  onInit() {
    super.onInit();
    getProfile();
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

  Future deleteProfile() async {
    try {
      updateProfileLoading.value = true;
      prepareServiceModel<bool>(await _repository.deleteProfile());
      //Başarılı olması halinde çıkış yapılıp sıfırlanıyor
      removeAllStore();
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
}
