import 'package:baby_monitor/data/controllers/security_controller.dart';
import 'package:baby_monitor/data/repositorys/security_repository.dart';
import 'package:baby_monitor/data/services/google_service.dart';
import 'package:get/get.dart';

class SecurtyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoogleService());
    Get.lazyPut(() => SecurityController());
    Get.lazyPut(() => SecurityRepository());
  }
}
