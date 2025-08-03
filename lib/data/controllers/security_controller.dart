import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/security_repository.dart';
import 'package:baby_monitor/data/services/google_service.dart';
import 'package:baby_monitor/models/security_models/login_model.dart';
import 'package:baby_monitor/models/security_models/register_model.dart';
import 'package:baby_monitor/models/security_models/reset_password_model.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SecurityController extends BaseController {
  var screanState = 0.obs;
  var title = "mb046".tr.obs;
  var loginLoading = false.obs;
  var registerLoading = false.obs;
  var googleLoginLoading = false.obs;
  var resetPasswordLoading = false.obs;
  late SecurityRepository _securityRepository;
  var loginModel = LoginModel();
  var registerModel = RegisterModel();
  var resetPasswordModel = ResetPasswordModel();

  SecurityController() {
    _securityRepository = Get.find();
  }
  login() async {
    try {
      loginLoading.value = true;
      loginModel.loginType = 0;
      var result = prepareServiceModel<String>(
        await _securityRepository.login(loginModel),
      );
      if (result != null) {
        setSession(result);
        setRememberMe(loginModel.toRememberMeModel());
        Get.offAndToNamed(RouteConst.home);
      }
    } catch (e) {
      exceptionHandle(e);
      loginLoading.value = false;
    }
  }
  //29.0.13113456

  //TODO bu bölüm canlıya çıkarken https://console.cloud.google.com/apis/credentials?inv=1&invt=AbtVcw&project=babywacth adresindeki SHA1 değeri canlının ki ile değişecek
  googleLogin() async {
    try {
      googleLoginLoading.value = true;
      var user = await GoogleService.googleLogin();
      registerModel.email = user?.email;
      registerModel.name = getName(user?.displayName ?? "");
      registerModel.surname = getSurname(user?.displayName ?? "");
      registerModel.googleId = user?.id ?? "";
      registerModel.loginType = 1;
      registerModel.image = user?.photoUrl;
      var result = prepareServiceModel<String>(
        await _securityRepository.register(registerModel),
      );
      if (result != null) {
        setSession(result);
        setRememberMe(registerModel.toRememberMeModel());
        Get.offAndToNamed(RouteConst.home);
      }
    } catch (e) {
      exceptionHandle(e);
      googleLoginLoading.value = false;
    }
  }

  register() async {
    try {
      registerLoading.value = true;
      registerModel.loginType = 0;
      var result = prepareServiceModel<String>(
        await _securityRepository.register(registerModel),
      );
      if (result != null) {
        setSession(result);
        setRememberMe(registerModel.toRememberMeModel());
        Get.offAndToNamed(RouteConst.home);
      }
    } catch (e) {
      registerLoading.value = false;
      exceptionHandle(e);
    }
  }

  //Reset password işlemleri yapılıp dönene mesaj ekranda gösterilmeli
  resetPassword() async {
    try {
      resetPasswordLoading.value = true;
      prepareServiceModel<bool>(
        await _securityRepository.resetPassword(resetPasswordModel),
      );
      resetPasswordLoading.value = false;
      showConfirmedMessage("auth016".tr, "auth017".tr);
    } catch (e) {
      resetPasswordLoading.value = false;
      exceptionHandle(e);
    }
  }

  getRegisterTab() {
    screanState.value = 1;
    title.value = "mb049".tr;
  }

  getLoginTab() {
    screanState.value = 2;
    title.value = "mb046".tr;
  }

  getForgetPasswordTab() {
    screanState.value = 3;
    title.value = "mb048".tr;
  }

  String getName(String displayName) {
    var names = displayName.split(" ");
    names.remove(names[names.length - 1]);
    return names.join(" ");
  }

  String getSurname(String displayName) {
    var names = displayName.split(" ");
    return names[names.length - 1];
  }

  Future<void> privacyPage() async {
    if (!await launchUrl(Uri.parse(ProjectConst.privacyUrl()))) {
      throw Exception('Could not launch');
    }
  }
}
