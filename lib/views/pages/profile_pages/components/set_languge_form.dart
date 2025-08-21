import 'package:baby_monitor/data/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetLangugeForm extends GetView<ProfileController> {
  const SetLangugeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Obx(() {
        if (controller.langugeLoading.value) {
          return LinearProgressIndicator();
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "mb067".tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              RadioMenuButton(
                value: "tr",
                groupValue: Get.locale?.languageCode ?? "tr",
                onChanged: (val) {
                  controller.setLanguge(val ?? "tr");
                },
                child: Text("Türkçe"),
              ),
              RadioMenuButton(
                value: "en",
                groupValue: Get.locale?.languageCode ?? "en",
                onChanged: (val) {
                  controller.setLanguge(val ?? "en");
                },
                child: Text("English"),
              ),
              RadioMenuButton(
                value: "de",
                groupValue: Get.locale?.languageCode ?? "de",
                onChanged: (val) {
                  controller.setLanguge(val ?? "de");
                },
                child: Text("Deutsch"),
              ),
            ],
          );
        }
      }),
    );
  }
}
