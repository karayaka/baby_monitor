import 'package:baby_monitor/data/controllers/streamer_controller.dart';
import 'package:baby_monitor/views/pages/streamer_pages/components/noise_meter_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

class StreamerPage extends GetView<StreamerController> {
  const StreamerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: Container(width: 200, height: 20),reklam için deneme
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  Obx(
                    () =>
                        controller.isConnecting.value
                            ? Center(child: Text('mb061'.tr))
                            : Positioned.fill(
                              child: RTCVideoView(
                                controller.localRenderer,
                                objectFit:
                                    RTCVideoViewObjectFit
                                        .RTCVideoViewObjectFitCover,
                              ),
                            ),
                  ),

                  // Sol üstte kapatma butonu
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: NoiseMeterComponent()),
          ],
        ),
      ),
    );
  }
}
