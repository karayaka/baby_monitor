import 'package:baby_monitor/data/controllers/viewer_controller.dart';
import 'package:baby_monitor/views/pages/viewer_pages/components/viewer_timer_component.dart';
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
                  controller.remoteRenderer,
                  mirror: true,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              );
            }),
            // Sol üstte kapatma butonu
            Positioned(
              top: 3,
              left: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close, color: Colors.black),
                    ),
                    Obx(() {
                      if (controller.isConnect.value == 1) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ViewerTimerComponent(
                            triggerSecond: 5,
                            tickTrigged: (second) {
                              controller.showAdd.value =
                                  !controller.showAdd.value;
                            },
                          ),
                        );
                      }
                      return SizedBox();
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
