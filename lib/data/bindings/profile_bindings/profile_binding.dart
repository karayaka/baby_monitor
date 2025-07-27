import 'package:baby_monitor/data/controllers/profile_controller.dart';
import 'package:baby_monitor/data/repositorys/security_repository.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => SecurityRepository());
  }
}
