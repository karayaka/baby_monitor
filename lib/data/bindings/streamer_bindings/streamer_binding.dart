import 'package:baby_monitor/data/controllers/streamer_controller.dart';
import 'package:baby_monitor/data/repositorys/stream_repoistory.dart';
import 'package:baby_monitor/views/pages/streamer_pages/components/noise_meter_controller.dart';
import 'package:get/get.dart';

class StreamerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StreamRepoistory());
    Get.lazyPut(() => StreamerController());
    Get.lazyPut(() => NoiseMeterController());
  }
}
