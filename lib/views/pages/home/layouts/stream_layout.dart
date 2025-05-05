import 'package:baby_monitor/data/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class StreamLayout extends GetView<HomeController> {
  const StreamLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Stream"),
      ),
      body: Container(),
    ));
  }
}
