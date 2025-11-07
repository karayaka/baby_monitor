import 'dart:async';
import 'dart:typed_data';
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
  late final FlutterSoundRecorder _recorder;
  StreamSubscription? _subscription;
  var onStream = false.obs;
  DateTime? _highDbStartTime;
  final int minCryDurationMs = 500; //nekadar aralık

  late final StreamRepoistory _repository;

  NoiseMeterController() {
    _repository = Get.find();
    dbLevel.value = getNoiseMeterDp() ?? 2;
  }

  @override
  void onInit() async {
    _recorder = FlutterSoundRecorder();
    super.onInit();
    await _initRecorder();
  }

  Future<void> _initRecorder() async {
    _highDbStartTime = null;
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      Get.snackbar('mb059'.tr, 'mb060'.tr);
      return;
    }
    await _recorder.openRecorder();
  }

  Future<void> startRecording() async {
    if (_recorder.isStopped) {
      await _initRecorder();
    }
    try {
      startListening.value = true;
      if (!_recorder.isRecording) {
        final StreamController<Uint8List> streamController =
            StreamController<Uint8List>();
        await _recorder.startRecorder(
          toStream: streamController,
          codec: Codec.pcm16,
          numChannels: 1,
          sampleRate: 44100,
        );

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
    } catch (e) {
      //timer bekletme işelmei hataya düşürüyor tekrar denenemeli
      await Future.delayed(Duration(seconds: 5));
      await startRecording();
    }
  }

  Future<void> checkDbLevel(double? db) async {
    try {
      if (dbLevel.value == 0) {
        return;
      }
      if ((db ?? 0) > _getThreshold()) {
        // Yüksek ses başladıysa zamanı kaydet
        _highDbStartTime ??= DateTime.now();
        // Yüksek sesin ne kadar sürdüğünü kontrol et
        int elapsed =
            DateTime.now().difference(_highDbStartTime!).inMilliseconds;
        if (elapsed > minCryDurationMs) {
          // Ağlama algılandı!
          _highDbStartTime = null;
          await _repository.callOtherDevice();
          await stopRecording();

          // Burada alarm, bildirim vs. tetikleyebilirsin
        }
      } else {
        // Ses seviyesi düştüyse zamanı sıfırla
        _highDbStartTime = null;
      }
    } catch (e) {
      rethrow;
    }
  }

  double _getThreshold() {
    if (dbLevel.value == 3) {
      return 30;
    } else if (dbLevel.value == 2) {
      return 40;
    } else {
      return 65;
    }
  }

  Future<void> setDbLevel(int level) async {
    await setNoiseMeterDp(level);
    dbLevel.value = level;
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
