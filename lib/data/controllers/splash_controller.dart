import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/security_repository.dart';
import 'package:baby_monitor/data/services/google_service.dart';
import 'package:baby_monitor/models/security_models/login_model.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  var controllerInt = "Hesap Bilgileri İnceleniyor".tr.obs;
  late SecurityRepository _securityRepository;
  SplashController() {
    _securityRepository = Get.find();
  }
  @override
  void onInit() async {
    if (await hasLogined()) {
      Get.offAllNamed(RouteConst.home);
    } else if (hasRememberMe()) {
      try {
        var loginModel = LoginModel();
        controllerInt.value = "Yeniden Giriş Yapılıyor".tr;
        var rememberMe = getRememberMe();
        if (rememberMe?.loginType == 1) {
          var user = await GoogleService.googleLogin();
          if (user == null) {
            Get.offAndToNamed(RouteConst.home);
          }
          loginModel.email = user?.email;
          loginModel.password = "";
          loginModel.loginType = 1;
        } else {
          loginModel.email = rememberMe?.email;
          loginModel.password = rememberMe?.password;
          loginModel.loginType = rememberMe?.loginType;
        }
        var result = prepareServiceModel<String>(
          await _securityRepository.login(loginModel),
        );
        if (result != null) {
          setSession(result);
          Get.offAndToNamed(RouteConst.home);
        }
      } catch (e) {
        Get.offAllNamed(RouteConst.security);
      }
    } else {
      Get.offAllNamed(RouteConst.security);
    }
    super.onInit();
  }

  Future _registerFirebase() async {}
}
