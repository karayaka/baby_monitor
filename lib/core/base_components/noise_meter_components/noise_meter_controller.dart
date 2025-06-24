import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:get/get.dart';

class NoiseMeterController extends BaseController {
  var startListening = false.obs;
  var countDown = 0.obs;
}
