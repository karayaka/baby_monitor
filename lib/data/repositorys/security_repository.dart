import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/repositorys/base_repository.dart';
import 'package:baby_monitor/data/services/http_service.dart';
import 'package:baby_monitor/models/base_models/base_result.dart';
import 'package:baby_monitor/models/profile_models/profile_model.dart';
import 'package:baby_monitor/models/security_models/change_password_model.dart';
import 'package:baby_monitor/models/security_models/login_model.dart';
import 'package:baby_monitor/models/security_models/register_model.dart';
import 'package:baby_monitor/models/security_models/reset_password_model.dart';

class SecurityRepository extends BaseRepository {
  late HttpService _service;
  SecurityRepository() {
    _service = HttpService.instance!;
  }

  Future<BaseResult> login(LoginModel model) async {
    try {
      return await _service.post("auth/Security/login", null, model);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> register(RegisterModel model) async {
    try {
      return await _service.post("auth/Security/Register", null, model);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> resetPassword(ResetPasswordModel model) async {
    try {
      return await _service.post(
        "auth/Security/SendResetPaswordMail",
        null,
        model,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> sendConfimEmail(ResetPasswordModel model) async {
    try {
      return await _service.post(
        "auth/Security/SendResetPaswordMail",
        null,
        model,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> changePassword(ChangePasswordModel model) async {
    try {
      return await _service.post(
        "auth/User/ChangePasswod",
        null,
        model,
        token: (getToken() ?? ""),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> getProfile() async {
    try {
      return await _service.get(
        "auth/User/GetUserProfile",
        ProfileModel(),
        token: (getToken() ?? ""),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> updateProfile(ProfileModel model) async {
    try {
      return await _service.post(
        "auth/User/UpdateProfile",
        null,
        model,
        token: (getToken() ?? ""),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> deleteProfile() async {
    try {
      return await _service.get(
        "auth/User/DeleteProfile",
        null,
        token: (getToken() ?? ""),
      );
    } catch (e) {
      rethrow;
    }
  }
}
