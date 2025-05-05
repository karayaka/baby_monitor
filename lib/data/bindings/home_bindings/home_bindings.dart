import 'package:baby_monitor/data/controllers/home_controller.dart';
import 'package:baby_monitor/data/repositorys/device_repository.dart';
import 'package:baby_monitor/data/repositorys/family_repoistory.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DeviceRepository());
    Get.lazyPut(() => FamilyRepoistory());
  }
}
