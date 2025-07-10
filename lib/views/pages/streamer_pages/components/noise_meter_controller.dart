import 'dart:async';
import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/stream_repoistory.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class NoiseMeterController extends BaseController {
  var startListening = false.obs;
  var dbLevel = 2.obs;
  var dbSize = 1.0.obs;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  StreamSubscription? _subscription;
  var onStream = false.obs;
  DateTime? _highDbStartTime;
  final int minCryDurationMs = 500; //nekadar aralık

  late final StreamRepoistory _repository;

  NoiseMeterController() {
    _repository = Get.find();
  }

  @override
  void onInit() async {
    super.onInit();
    await _initRecorder();
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      Get.snackbar('İzin Gerekli', 'Mikrofon izni verilmedi!');
      return;
    }
    await _recorder.openRecorder();
  }

  Future<void> startRecording() async {
    if (_recorder.isStopped) {
      await _initRecorder();
    }
    startListening.value = true;
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/sound.aac';
    if (!_recorder.isRecording) {
      await _recorder.startRecorder(toFile: path, codec: Codec.aacADTS);

      _subscription = _recorder.onProgress!.listen((event) async {
        double? db = event.decibels;
        if (db != null) {
          if (db > 100) db = 100.0;
          dbSize.value = db / 100; // UI'da göstermek için
          await checkDbLevel(db);
        }
      });
      await _recorder.setSubscriptionDuration(
        Duration(milliseconds: 100), // 100 ms
      );
    }
  }

  Future<void> checkDbLevel(double? db) async {
    if (dbLevel.value == 0) {
      return;
    }
    if ((db ?? 0) > _getThreshold()) {
      // Yüksek ses başladıysa zamanı kaydet
      _highDbStartTime ??= DateTime.now();
      // Yüksek sesin ne kadar sürdüğünü kontrol et
      int elapsed = DateTime.now().difference(_highDbStartTime!).inMilliseconds;
      if (elapsed > minCryDurationMs) {
        // Ağlama algılandı!
        _repository.callOtherDevice();
        await stopRecording();
        _highDbStartTime = null;
        // Burada alarm, bildirim vs. tetikleyebilirsin
      }
    } else {
      // Ses seviyesi düştüyse zamanı sıfırla
      _highDbStartTime = null;
    }
  }

  double _getThreshold() {
    if (dbLevel.value == 3) {
      return 45;
    } else if (dbLevel.value == 2) {
      return 55;
    } else {
      return 65;
    }
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
    startListening.value = false;
  }

  @override
  void onClose() async {
    await _recorder.stopRecorder();
    await _recorder.closeRecorder();
    await _subscription?.cancel();
    super.dispose();
  }
}
