import 'package:baby_monitor/data/controllers/viewer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

class ViewerPage extends GetView<ViewerController> {
  const ViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Obx(() {
              if (controller.isConnect.value == 0) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.isConnect.value == 2) {
                return Center(child: Text("mb008".tr));
              }
              return Positioned.fill(
                child: RTCVideoView(
                  controller.remoteRenderer, // <-- Burada positional argüman
                  mirror: true,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              );
            }),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
