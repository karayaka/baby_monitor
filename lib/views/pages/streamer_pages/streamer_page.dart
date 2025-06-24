import 'package:baby_monitor/core/base_components/timer_components/down_timer_component.dart';
import 'package:baby_monitor/data/controllers/streamer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

class StreamerPage extends GetView<StreamerController> {
  const StreamerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Kamera görüntüsü (arkaplan)
            Obx(
              () =>
                  controller.isConnecting.value
                      ? const Center(
                        child: Text('Kamera akışı başlatılıyor...'),
                      )
                      : Positioned.fill(
                        child: RTCVideoView(controller.localRenderer),
                      ),
            ),

            // Sol üstte kapatma butonu
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close, color: Colors.black),
              ),
            ),

            // Alt kısımda geri sayım veya "Dinleme"
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Obx(() {
                if (controller.listening.value) {
                  return const Text(
                    "Dinleme",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  );
                }
                return DownTimerComponent(
                  label: "Dinleme Başlıyor",
                  onTimeEnd: () async {
                    // işlemler
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
