import 'package:baby_monitor/data/controllers/streamer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

class StreamerPage extends GetView<StreamerController> {
  const StreamerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stream Ekranı")),
      body: SizedBox(
        child: Obx(
          () => Column(
            //TODO button veya ses algılama ekranı tasarımı için eklendi
            children: [
              Expanded(
                child:
                    !controller.isConnecting.value
                        ? RTCVideoView(controller.localRenderer)
                        : const Text('Kamera akışı başlatılıyor...'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
