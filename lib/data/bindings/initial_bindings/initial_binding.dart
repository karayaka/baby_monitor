import 'package:baby_monitor/data/repositorys/security_repository.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SecurityRepository());
  }
}
