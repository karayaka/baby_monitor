import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/controllers/profile_controller.dart';
import 'package:baby_monitor/views/pages/profile_pages/components/delete_profile_warning_ui.dart';
import 'package:baby_monitor/views/pages/profile_pages/components/set_languge_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingLayout extends GetView<ProfileController> {
  const SettingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            if (controller.privacyLoading.value) {
              return LinearProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.onSecondary,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: controller.privacyPage,
                      child: Text(
                        "mb064".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text("mb070".tr),
                          SizedBox(width: 10),
                          Text(
                            (controller.policyStorageModel?.acceptanceDate
                                    ?.toIso8601String()) ??
                                "",
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.dialog(
                              barrierDismissible: false,
                              DeleteProfileWarningUi(),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red, // Metin ve ikon rengi
                            side: BorderSide(color: Colors.red), // Kenarlık
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                3,
                              ), // Yuvarlak köşeler
                            ),
                          ),
                          child: Text(
                            "mb044".tr,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.onSecondary,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Text(
                    "mb071".tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Obx(() {
                    if (controller.langugeLoading.value) {
                      return CircularProgressIndicator();
                    }
                    return Text(
                      ProjectConst.getLangugeText(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  }),

                  Spacer(),
                  IconButton(
                    onPressed: () => Get.dialog(SetLangugeForm()),
                    icon: Icon(Icons.language),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Get.dialog(SetLangugeForm());
