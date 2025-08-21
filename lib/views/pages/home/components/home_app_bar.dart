import 'package:baby_monitor/data/controllers/home_controller.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/views/pages/home/components/home_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends GetView<HomeController> {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      height: 110,
      width: Get.width,
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Image.asset(
                  "assets/icon/and_icon.png",
                  width: 50,
                  height: 50,
                ),
              ),
              Spacer(),
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
          HomeProfileCard(session: controller.getSession()),
        ],
      ),
    );
  }
}
