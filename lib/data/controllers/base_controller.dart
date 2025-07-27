import 'dart:convert';
import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/models/base_models/base_error.dart';
import 'package:baby_monitor/models/base_models/base_result.dart';
import 'package:baby_monitor/models/exception_models/custom_exception.dart';
import 'package:baby_monitor/models/security_models/remember_me_model.dart';
import 'package:baby_monitor/models/security_models/session_model.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class BaseController extends GetxController {
  int guardStatus = 0;
  String message = "";
  DateTime date = DateTime.now();
  I? prepareServiceModel<I>(BaseResult model) {
    try {
      if (model.statusCode == 200) {
        message = model.message ?? "";
        date = model.date ?? DateTime.now();
        return model.data;
      } else if (model.statusCode == 401 &&
          Get.currentRoute != RouteConst.security) {
        Get.offAllNamed(RouteConst.security);
      } else {
        errorMessage(message);
      }
      return null;
    } catch (e) {
      errorMessage(e.toString());
      return null;
    }
  }

  exceptionHandle(Object? e) {
    if (e is DioException) {
      if (e.response?.data == null || e.response == null) {
        errorMessage("Bir Hata Oluştu.".tr);
      } else if (e.response!.statusCode == 401 &&
          Get.currentRoute != RouteConst.security) {
        Get.toNamed(RouteConst.security); // giriş yapılamam hali ise
      } else {
        if (e.response!.data is List) {
          var errors = List<BaseError>.from(
            e.response!.data.map((s) => BaseError.fromJson(s)),
          );
          List<String> errorMessages = [];
          for (var err in errors) {
            errorMessages.addAll(err.values!);
          }
          errorMessage(
            "Hata".tr,
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _showValidateError(errorMessages),
            ),
          );
        } else {
          try {
            var err = BaseError.fromJson(jsonDecode(e.response!.data!));
            errorMessage(err.values?.first ?? "".tr);
          } catch (e) {
            errorMessage("gl002".tr);
          }
        }
      }
    } else if (e is CustomException) {
      errorMessage(e.toString());
    } else {
      errorMessage("Bir Hata Oluştu.".tr);
    }
  }

  _showValidateError(List<String> errorMessages) {
    List<Widget> content = [];
    for (var i in errorMessages) {
      content.add(Text(i.tr, style: const TextStyle(color: Colors.white)));
    }
    return content;
  }

  showConfirmeDialog(
    void Function()? onConfirme, {
    String title = "",
    String message = "",
    String confirmeText = "Tamam",
  }) {
    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ), // Burada yazı boyutunu ayarlıyorsunuz
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Yatayda ortalamak için
        children: [
          Text(
            message,
            textAlign: TextAlign.center, // Mesajın içeriğini de ortalıyoruz
          ),
        ],
      ),
      onConfirm: onConfirme,
      textCancel: "İptal".tr,
      textConfirm: confirmeText,
      confirmTextColor: Colors.white,
    );
  }

  showConfirmedMessage(String title, String message) {
    Get.defaultDialog(
      title: title,
      textConfirm: "gl003".tr,
      onConfirm: () => Get.back(),
      titleStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ), // Burada yazı boyutunu ayarlıyorsunuz
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Yatayda ortalamak için
        children: [
          Text(
            message,
            textAlign: TextAlign.center, // Mesajın içeriğini de ortalıyoruz
          ),
        ],
      ),
      confirmTextColor: Colors.white,
    );
  }

  succesMessage(String message) {
    Get.snackbar(
      "Başarılı".tr,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.green,
    );
  }

  errorMessage(String message, {Widget? widget}) {
    Get.snackbar(
      "Hata".tr,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      messageText: widget,
    );
  }

  warningMessage(String message) {
    Get.snackbar(
      "Uyarı",
      message,
      colorText: Colors.white,
      backgroundColor: Colors.orange.shade600,
    );
  }

  showProgressDialog({title = "gl004"}) {
    Get.dialog(
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(title), CircularProgressIndicator()],
        ),
      ),
      barrierDismissible: false,
    );
  }

  closeProgressDilog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(ProjectConst.SESSION_CONTS);
  }

  SessionModel? getSession() {
    String? jwt = getToken();
    return _jwtConvert(jwt);
  }

  setSession(String jwt) {
    final box = GetStorage();
    box.write(ProjectConst.SESSION_CONTS, jwt);
  }

  removeAllStore() {
    final box = GetStorage();
    box.erase();
  }

  bool isTokenExpired() {
    var session = getSession();
    return (session?.expiredDate?.isBefore(DateTime.now()) ?? true);
  }

  setRememberMe(RememberMeModel model) {
    final box = GetStorage();
    box.write(ProjectConst.REMEMBER_ME, model);
  }

  RememberMeModel? getRememberMe() {
    final box = GetStorage();

    var rmMap = box.read(ProjectConst.REMEMBER_ME);
    if (rmMap == null) {
      return null;
    }
    var rememberMe = RememberMeModel();
    rememberMe.fromJson(rmMap);
    return rememberMe;
  }

  bool hasRememberMe() => getRememberMe() != null;

  hasLogined() {
    return getToken() != null && !isTokenExpired();
  }

  SessionModel? _jwtConvert(String? jwt) {
    if (jwt != null) {
      var jwtToken = JwtDecoder.decode(jwt);
      var session = SessionModel();
      session.fromJson(jwtToken);
      return session;
    }
    return null;
  }

  setDeviceToken(String deviceToken) {
    final box = GetStorage();
    box.write(ProjectConst.DEVICE_TOKEN_CONTS, deviceToken);
  }

  String? getDeviceToken() {
    final box = GetStorage();
    var token = box.read(ProjectConst.DEVICE_TOKEN_CONTS);
    return token;
  }

  bool hasDeviceToken() => getDeviceToken() != null;

  void setNoiseMeterDp(int db) {
    final box = GetStorage();
    box.write(ProjectConst.NOISE_METER_DEB, db);
  }

  int? getNoiseMeterDp() {
    final box = GetStorage();
    return box.read(ProjectConst.NOISE_METER_DEB);
  }
}
