import 'package:baby_monitor/core/base_components/noise_meter_components/noise_meter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoiseMeterComponent extends GetView<NoiseMeterController> {
  const NoiseMeterComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NoiseMeterComponent());
    return const Placeholder();
  }
}
