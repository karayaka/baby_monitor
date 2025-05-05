import 'package:baby_monitor/data/controllers/security_controller.dart';
import 'package:baby_monitor/views/pages/security_pages/components/security_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends GetView<SecurityController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            initialValue: controller.loginModel.email,
            onChanged: (val) => controller.loginModel.email = val,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Email".tr,
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            obscureText: true,
            initialValue: controller.loginModel.password,
            onChanged: (val) => controller.loginModel.password = val,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.key),
                hintText: "Şifre".tr,
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 5,
          ),
          Obx(() => SecurityButton(
                text: "Giriş".tr,
                onTab: controller.login,
                isLoading: controller.loginLoading.value,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: controller.getRegisterTab,
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back),
                      Text("Kayıt Ol".tr),
                    ],
                  )),
              TextButton(
                  onPressed: controller.getForgetPasswordTab,
                  child: Row(
                    children: [
                      Text("Şifremi Unuttum".tr),
                      Icon(Icons.arrow_forward),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
