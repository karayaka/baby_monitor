import 'package:baby_monitor/data/controllers/profile_controller.dart';
import 'package:baby_monitor/views/pages/profile_pages/layouts/profile_layout.dart';
import 'package:baby_monitor/views/pages/profile_pages/layouts/setting_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.colorScheme.onSecondary,
          centerTitle: true,
        ),
        backgroundColor: Get.theme.colorScheme.onSecondary,
        body: TabBarView(children: [ProfileLayout(), SettingLayout()]),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.person), text: "mb068".tr),
            Tab(icon: Icon(Icons.settings), text: "mb069".tr),
          ],
        ),
      ),
    );
  }
}
