import 'package:baby_monitor/data/controllers/device_controller.dart';
import 'package:baby_monitor/data/repositorys/device_repository.dart';
import 'package:baby_monitor/data/repositorys/send_notifire_repoistory.dart';
import 'package:get/get.dart';

class DeviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeviceController());
    Get.lazyPut(() => DeviceRepository());
    Get.lazyPut(() => SendNotifireRepoistory());
  }
}
