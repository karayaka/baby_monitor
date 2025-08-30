import 'package:baby_monitor/data/controllers/home_controller.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/views/pages/home/components/home_profile_card.dart';
import 'package:baby_monitor/views/pages/home/layouts/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// ignore: must_be_immutable
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          title: Image.asset("assets/icon/and_icon.png", width: 50, height: 50),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: HomeProfileCard(session: controller.getSession()),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(RouteConst.profile),
              icon: Icon(Icons.settings),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () => Get.toNamed(RouteConst.apps),
              icon: Icon(Icons.info),
              color: Colors.white,
            ),
          ],
        ),
        bottomNavigationBar: Obx(() {
          if (controller.isAdLoaded.value) {
            return SizedBox(
              height: controller.bannerAd?.size.height.toDouble(),
              width: controller.bannerAd?.size.width.toDouble(),
              child: AdWidget(ad: controller.bannerAd!),
            );
          } else {
            return const SizedBox(height: 8);
          }
        }),
        body: Obx(() {
          if (controller.addDeviceLoaing.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("gl005".tr), CircularProgressIndicator()],
              ),
            );
          } else {
            return HomeLayout();
          }
        }),
        floatingActionButton: Obx(() {
          if (controller.deviceList.length < 2) {
            return SizedBox();
          } else {
            return FloatingActionButton(
              child: Icon(Icons.linked_camera_outlined),
              onPressed: () => controller.showRewardedAd(),
            );
          }
        }),
      ),
    );
  }
}
