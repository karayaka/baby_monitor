import 'package:baby_monitor/data/controllers/family_controller.dart';
import 'package:baby_monitor/data/repositorys/family_repoistory.dart';
import 'package:get/get.dart';

class FamilyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FamilyRepoistory());
    Get.lazyPut(() => FamilyController());
  }
}
