import 'package:baby_monitor/data/controllers/viewer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

class ViewerPage extends GetView<ViewerController> {
  const ViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("İzleme Ekranı"), centerTitle: true),
      body: Obx(() {
        if (controller.isConnect.value == 2) {
          controller.warningMessage("BAğlantı koptu");
          Get.back();
        }
        return Column(
          children: [
            Expanded(
              child:
                  controller.isConnect.value == 1
                      ? RTCVideoView(controller.remoteRenderer)
                      : const Text(
                        'Kamera akışı başlatılıyor...',
                      ), //TODO prores olacak component yazılacak
            ),
          ],
        );
      }),
    );
  }
}
