import 'package:baby_monitor/data/controllers/viewer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

class ViewerPage extends GetView<ViewerController> {
  const ViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isConnect.value == 0) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isConnect.value == 2) {
          return Center(child: Text("mb008".tr));
        }
        return Stack(
          children: [
            // Sol üstte kapatma butonu
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close, color: Colors.black),
              ),
            ),
            Expanded(
              child:
                  controller.isConnect.value == 1
                      ? RTCVideoView(controller.remoteRenderer)
                      : Center(child: const CircularProgressIndicator()),
            ),
          ],
        );
      }),
    );
  }
}
