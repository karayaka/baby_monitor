import 'package:baby_monitor/data/controllers/security_controller.dart';
import 'package:baby_monitor/data/repositorys/security_repository.dart';
import 'package:get/get.dart';

class SecurtyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SecurityController());
    Get.lazyPut(() => SecurityRepository());
  }
}
