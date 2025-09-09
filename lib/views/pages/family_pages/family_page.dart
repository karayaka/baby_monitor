import 'package:baby_monitor/data/controllers/family_controller.dart';
import 'package:baby_monitor/views/pages/family_pages/layouts/add_family_layout.dart';
import 'package:baby_monitor/views/pages/family_pages/layouts/family_list_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class FamilyPage extends GetView<FamilyController> {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () =>
              controller.familyModel.value.id == null
                  ? Text("mb002".tr)
                  : Text(controller.familyModel.value.name ?? ""),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Obx(
            () =>
                controller.familyLoading.value
                    ? LinearProgressIndicator()
                    : Container(),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        if (controller.isBottomLoaded.value) {
          return SizedBox(
            height: controller.bottomBannerAd?.size.height.toDouble(),
            width: controller.bottomBannerAd?.size.width.toDouble(),
            child: AdWidget(ad: controller.bottomBannerAd!),
          );
        } else {
          return const SizedBox(height: 8);
        }
      }),
      body: Obx(
        () =>
            controller.familyModel.value.id == null
                ? AddFamilyLayout()
                : FamilyListLayout(),
      ),
      floatingActionButton: Obx(
        () =>
            controller.familyModel.value.id == null
                ? SizedBox()
                : FloatingActionButton(
                  onPressed: () => _drawFamilyQrCode(),
                  child: Icon(Icons.login_outlined),
                ),
      ),
    );
  }

  void _drawFamilyQrCode() {
    Get.bottomSheet(
      isDismissible: false,
      Material(
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                Text(
                  "mb024".tr,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Get.back();
                    controller.getFamily();
                  },
                  icon: Icon(Icons.close, color: Colors.black),
                ),
                SizedBox(width: 5),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PrettyQrView.data(
                  data: controller.familyModel.value.id ?? "",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
