import 'package:baby_monitor/core/app_tools/project_validations.dart';
import 'package:baby_monitor/data/controllers/family_controller.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/views/shared/components/custom_card_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFamilyLayout extends GetView<FamilyController> {
  const AddFamilyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomCardButton(
            onPressed: () {
              controller.addFamilyModel.name =
                  (controller.getSession()?.lastName ?? "") + (" - mb013").tr;
              _openBottomSheet();
            },
            title: "mb014".tr,
            desc: "mb015".tr,
            iconData: Icons.people_alt_outlined,
          ),
          CustomCardButton(
            onPressed: () => Get.toNamed(RouteConst.joinFamilyLayout),
            title: "mb016".tr,
            desc: "mb017".tr,
            iconData: Icons.person_add_alt_1_outlined,
          ),
        ],
      ),
    );
  }

  void _openBottomSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "mb018".tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: controller.addFamilyModel.name,
              decoration: InputDecoration(
                labelText: "mb019".tr,
                border: OutlineInputBorder(),
              ),
              validator: (value) => ProjectValidations.notEmty(value),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.addFamilyLoading.value) {
                return LinearProgressIndicator();
              } else {
                return Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red, // Yazı ve ikon rengi
                          side: const BorderSide(
                            color: Colors.red,
                          ), // Kenar çizgisi
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () => Get.back(),
                        child: Text("gl007".tr),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green, // Yazı ve ikon rengi
                          side: const BorderSide(
                            color: Colors.green,
                          ), // Kenar çizgisi
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () => controller.addFamily(),
                        child: Text("gl008".tr),
                      ),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
    );
  }
}
