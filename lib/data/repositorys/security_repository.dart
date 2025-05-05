import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/repositorys/base_repository.dart';
import 'package:baby_monitor/data/services/http_service.dart';
import 'package:baby_monitor/models/base_models/base_result.dart';
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
      return _service.post("auth/Security/login", null, model);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> register(RegisterModel model) async {
    try {
      return _service.post("auth/Security/Register", null, model);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> resetPassword(ResetPasswordModel model) async {
    try {
      return _service.post("auth/Security/SendResetPaswordMail", null, model);
    } catch (e) {
      rethrow;
    }
  }
}
