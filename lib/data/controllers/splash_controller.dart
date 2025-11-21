import 'dart:io';

import 'package:baby_monitor/core/app_tools/ad_helper.dart';
import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/security_repository.dart';
import 'package:baby_monitor/data/services/google_service.dart';
import 'package:baby_monitor/models/security_models/login_model.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends BaseController {
  var controllerInt = "mb062".tr.obs;
  late SecurityRepository _securityRepository;
  late GoogleService _service;
  AppOpenAd? _appOpenAd;
  SplashController() {
    _securityRepository = Get.find();
    _service = Get.find();
  }
  @override
  void onInit() async {
    await requestIgnoreBatteryOptimizations();
    await _requestPermissions();
    if (await hasLogined()) {
      await FirebaseDatabase.instance.ref("splash_logs").push().set({
        "hasLogined": "true",
      });
      Get.offAllNamed(RouteConst.home);
    } else if (hasRememberMe()) {
      try {
        await FirebaseDatabase.instance.ref("splash_logs").push().set({
          "hasRememberMe": "true",
        });
        var loginModel = LoginModel();
        controllerInt.value = "Yeniden Giriş Yapılıyor".tr;
        var rememberMe = getRememberMe();
        await FirebaseDatabase.instance.ref("splash_logs").push().set({
          "getRememberMe": rememberMe?.toJson(),
        });
        if (rememberMe?.loginType == 1) {
          var user = await _service.googleLogin();
          if (user == null) {
            Get.offAllNamed(RouteConst.security);
            await FirebaseDatabase.instance.ref("splash_logs").push().set({
              "googleloginUserNull": "GoogleUserNull",
            });
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
          await setSession(result);
          Get.offAllNamed(RouteConst.home);
        }
      } catch (e) {
        Get.offAllNamed(RouteConst.security);
      }
    } else {
      Get.offAllNamed(RouteConst.security);
    }
    await MobileAds.instance.initialize();
    super.onInit();
    _loadAppOpenAd();
  }

  Future<void> requestIgnoreBatteryOptimizations() async {
    if (Platform.isAndroid) {
      await Permission.ignoreBatteryOptimizations.request();
    }
  }

  void _loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: AdHelper.appOpenAdID,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _appOpenAd!.show();
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();
  }

  @override
  void onClose() {
    _appOpenAd?.dispose();
    super.onClose();
  }
}
