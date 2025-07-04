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
        body: Obx(() {
          if (controller.isConnect.value == 0) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.isConnect.value == 2) {
            return Center(child: Text("mb008".tr));
          }

          return Expanded(
            child: RTCVideoView(
              controller.remoteRenderer,
              mirror: true,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          );
        }),
      ),
    );
  }
}
