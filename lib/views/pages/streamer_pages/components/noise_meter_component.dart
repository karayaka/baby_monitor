import 'package:baby_monitor/core/base_components/timer_components/down_timer_component.dart';
import 'package:baby_monitor/views/pages/streamer_pages/components/noise_meter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoiseMeterComponent extends GetView<NoiseMeterController> {
  const NoiseMeterComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Obx(() {
            if (controller.startListening.value) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: LinearProgressIndicator(
                  value: controller.dbSize.value,
                  minHeight: 10,
                ),
              );
            }
            if (!controller.onStream.value) {
              return DownTimerComponent(
                label: "mb051".tr,
                onTimeEnd: () async {
                  await controller.startRecording();
                },
              );
            } else {
              return Text("mb052".tr); //Bu bölüm düşünülecek
            }
          }),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            onPressed:
                () => Get.bottomSheet(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  Wrap(
                    children: [
                      Center(
                        child: Text(
                          "mb053".tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(child: Text("mb054".tr)),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.dbLevel.value == 0
                                          ? Colors.blue
                                          : Colors.grey[300],
                                  foregroundColor:
                                      controller.dbLevel.value == 0
                                          ? Colors.white
                                          : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  controller.setDbLevel(0);
                                },
                                child: Text("mb055".tr),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.dbLevel.value == 1
                                          ? Colors.blue
                                          : Colors.grey[300],
                                  foregroundColor:
                                      controller.dbLevel.value == 1
                                          ? Colors.white
                                          : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () async {
                                  controller.setDbLevel(1);
                                },
                                child: Text("mb056".tr),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.dbLevel.value == 2
                                          ? Colors.blue
                                          : Colors.grey[300],
                                  foregroundColor:
                                      controller.dbLevel.value == 2
                                          ? Colors.white
                                          : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  controller.setDbLevel(2);
                                },
                                child: Text("mb057".tr),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      controller.dbLevel.value == 3
                                          ? Colors.blue
                                          : Colors.grey[300],
                                  foregroundColor:
                                      controller.dbLevel.value == 3
                                          ? Colors.white
                                          : Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  controller.setDbLevel(3);
                                },
                                child: Text("mb058".tr),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            icon: Icon(Icons.settings),
          ),
        ),
      ],
    );
  }
}
