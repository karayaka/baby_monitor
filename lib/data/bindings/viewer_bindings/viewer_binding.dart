import 'package:baby_monitor/data/controllers/device_controller.dart';
import 'package:baby_monitor/data/controllers/viewer_controller.dart';
import 'package:baby_monitor/data/repositorys/device_repository.dart';
import 'package:baby_monitor/data/repositorys/stream_repoistory.dart';
import 'package:get/get.dart';

class ViewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeviceController());
    Get.lazyPut(() => DeviceRepository());
    Get.lazyPut(() => StreamRepoistory());
    Get.lazyPut(() => ViewerController());
  }
}
