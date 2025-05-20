import 'package:baby_monitor/data/controllers/home_controller.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/views/pages/home/layouts/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (controller.addDeviceLoaing.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("gl005"), CircularProgressIndicator()],
              ),
            );
          } else {
            return HomeLayout();
          }
        }),
        floatingActionButton: Obx(() {
          if (controller.deviceList.length < 2 &&
              controller.addDeviceLoaing.value) {
            return SizedBox();
          } else {
            return FloatingActionButton(
              child: Icon(Icons.linked_camera_outlined),
              onPressed: () => Get.toNamed(RouteConst.streamerScrean),
            );
          }
        }),
      ),
    );
  }
}
