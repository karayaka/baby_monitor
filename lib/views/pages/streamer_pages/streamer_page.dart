import 'package:baby_monitor/data/controllers/streamer_controller.dart';
import 'package:baby_monitor/views/pages/streamer_pages/components/noise_meter_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class StreamerPage extends GetView<StreamerController> {
  const StreamerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: Obx(() {
        if (controller.isBottomLoaded.value) {
          return SizedBox(
            height: controller.bottomBannerAd?.size.height.toDouble(),
            width: controller.bottomBannerAd?.size.width.toDouble(),
            child: AdWidget(ad: controller.bottomBannerAd!),
          );
        } else {
          return const SizedBox();
        }
      }),*/
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
                    top: 5,
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
                  Positioned(
                    top: 0,
                    right: 10,
                    child: Obx(
                      () =>
                          controller.isTopAdLoaded.value
                              ? SizedBox(
                                height:
                                    controller.topBannerAd?.size.height
                                        .toDouble(),
                                width:
                                    controller.topBannerAd?.size.width
                                        .toDouble(),
                                child: AdWidget(ad: controller.topBannerAd!),
                              )
                              : SizedBox(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 10,
                    child: Obx(
                      () =>
                          controller.isBottomLoaded.value
                              ? SizedBox(
                                height:
                                    controller.bottomBannerAd?.size.height
                                        .toDouble(),
                                width:
                                    controller.bottomBannerAd?.size.width
                                        .toDouble(),
                                child: AdWidget(ad: controller.bottomBannerAd!),
                              )
                              : SizedBox(),
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
