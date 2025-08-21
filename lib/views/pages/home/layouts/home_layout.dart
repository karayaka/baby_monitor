import 'package:baby_monitor/data/controllers/home_controller.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/views/pages/device_pages/components/on_live_comonent.dart';
import 'package:baby_monitor/views/pages/home/components/family_card.dart';
import 'package:baby_monitor/views/pages/home/components/home_app_bar.dart';
import 'package:baby_monitor/views/pages/home/components/device_card.dart';
import 'package:baby_monitor/views/pages/home/components/on_stram_device_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLayout extends GetView<HomeController> {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.addDevice();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //HomeAppBar(),
            SizedBox(height: 10),
            Obx(
              () => DeviceCard(
                onTab: () => Get.toNamed(RouteConst.deviceList),
                deviceCount: controller.deviceList.length,
                loading: controller.deviceListLoaing.value,
              ),
            ),
            Obx(
              () => FamilyCard(
                onTab: () => Get.toNamed(RouteConst.familyList),
                memberCount: controller.familyModel.value.members?.length ?? 0,
                loading: controller.familyLoading.value,
              ),
            ),
            SizedBox(height: 10),
            Obx(() {
              if (controller.deviceListLoaing.value) {
                return Center(child: CircularProgressIndicator());
              }
              return OnStramDeviceCard();
            }),
          ],
        ),
      ),
    );
  }
}
