import 'package:baby_monitor/data/controllers/security_controller.dart';
import 'package:baby_monitor/views/pages/security_pages/components/google_login_button.dart';
import 'package:baby_monitor/views/pages/security_pages/layouts/login_form.dart';
import 'package:baby_monitor/views/pages/security_pages/layouts/register_form.dart';
import 'package:baby_monitor/views/pages/security_pages/layouts/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/login_divider.dart';

class SecurityPage extends GetView<SecurityController> {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(
          () =>
              Text(controller.title.value, style: Get.textTheme.headlineMedium),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Image.asset("assets/icon/and_icon.png", width: 200, height: 200),
              SizedBox(height: 10),
              Obx(() {
                Widget child = LoginForm();
                if (controller.screanState.value == 1) {
                  child = RegisterForm();
                } else if (controller.screanState.value == 3) {
                  child = ResetPassword();
                }
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    final slideAnimation = Tween<Offset>(
                      begin: Offset(1.0, 0.0), // Sağdan başlasın
                      end: Offset(0.0, 0.0), // Normal konumuna gelsin
                    ).animate(animation);
                    return SlideTransition(
                      position: slideAnimation,
                      child: child,
                    );
                  },
                  child: child,
                );
              }),
              LoginDivider(),
              SizedBox(height: 10),
              Obx(
                () => GoogleLoginButton(
                  privacyPage: () async {
                    await controller.privacyPage();
                  },
                  isLoading: controller.googleLoginLoading.value,
                  onTab: () {
                    controller.googleLogin();
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
