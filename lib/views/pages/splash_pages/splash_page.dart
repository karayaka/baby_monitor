import 'package:baby_monitor/data/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.controllerInt;
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.onSecondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Obx(() => Text(controller.controllerInt.value))
          ],
        ),
      ),
    );
  }
}
