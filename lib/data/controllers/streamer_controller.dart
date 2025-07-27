import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/stream_repoistory.dart';
import 'package:baby_monitor/views/pages/streamer_pages/components/noise_meter_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class StreamerController extends BaseController {
  late final StreamRepoistory _repository;
  var isConnecting = false.obs;
  var msg = "".obs;
  webrtc.MediaStream? _localStream;
  final webrtc.RTCVideoRenderer localRenderer = webrtc.RTCVideoRenderer();
  late Map<String, dynamic> config;
  var listening = false.obs;
  Map<String, webrtc.RTCPeerConnection> pcs = {};
  StreamerController() {
    _repository = Get.find();
  }
  //TODO Bu sayfada ekran parlaklığı kısalabilir!
  @override
  void onReady() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    isConnecting.value = true;
    config = await _repository.fetchIceServers();
    await _repository.connect(
      sendOffer: sendOffer,
      sendCandidate: sendCandidate,
    );
    await _requestPermissions();
    await _startStream();
    isConnecting.value = false;
    WakelockPlus.enable();
    super.onReady();
  }

  Future<void> _startStream() async {
    try {
      await _repository.startStream();
      await localRenderer.initialize();

      _localStream = await webrtc.navigator.mediaDevices.getUserMedia({
        'audio': {
          'echoCancellation': false,
          'noiseSuppression': false,
          'autoGainControl': false,
        },
        'video': {
          'facingMode': 'environment',
          'width': 320,
          'height': 240,
          'frameRate': 10,
        },
      });

      localRenderer.srcObject = _localStream;
      await _repository.sendStartStreamNotification("mb006".tr, "mb007".tr);
    } catch (e) {
      exceptionHandle(e);
    }
  }

  ///İzleyiciden gelen offerler işlenecek
  void sendOffer(dynamic data) async {
    try {
      final pc = await _createPeerConnection();

      pc.onConnectionState = (state) async {
        //TODO Yayın durdurma ve bağlantı yönetimleri çoklu çihazlaral test edilmeli!!!
        if (state ==
                webrtc.RTCPeerConnectionState.RTCPeerConnectionStateFailed ||
            state ==
                webrtc
                    .RTCPeerConnectionState
                    .RTCPeerConnectionStateDisconnected ||
            state ==
                webrtc.RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
          await pc.close();
          pcs.remove(data[0]);
        }

        if (pcs.isEmpty) {
          Get.find<NoiseMeterController>().onStream.value = false;
        }
      };

      //local stream veri setine eklenyor
      _localStream?.getTracks().forEach((track) {
        pc.addTrack(track, _localStream!);
      });
      pc.onIceCandidate = (candidate) {
        _repository.sendtoCliend(
          data[0],
          HubMethods.sendAnswerCandidate,
          candidate.toMap(),
        );
      };

      await pc.setRemoteDescription(
        webrtc.RTCSessionDescription(data[1]["sdp"], data[1]["type"]),
      );
      //sd cevap oluşturuluyor
      final answer = await pc.createAnswer();
      await pc.setLocalDescription(answer);
      //sd cevap gönderiliyor
      await _repository.sendtoCliend(
        data[0],
        HubMethods.sendAnswer,
        answer.toMap(),
      );
      if (pcs[data[0]] != null) {
        pcs.remove(pcs[data[0]]);
      }
      pcs[data[0]] = pc;
      if (pcs.isNotEmpty) {
        Get.find<NoiseMeterController>().onStream.value = true;
        Get.find<NoiseMeterController>().stopRecording();
      }
    } catch (e) {
      exceptionHandle(e);
    }
  }

  ///İzleyiciden gelen Candidateler işelenecek
  void sendCandidate(dynamic data) async {
    try {
      //Hubdan glen candiateler bu şekile ekleniyor

      await pcs[data[0]]?.addCandidate(
        webrtc.RTCIceCandidate(
          data[1]['candidate'],
          data[1]['sdpMid'],
          data[1]['sdpMLineIndex'],
        ),
      );
    } catch (e) {
      exceptionHandle(e);
    }
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();
  }

  Future<webrtc.RTCPeerConnection> _createPeerConnection() async {
    final peerConnection = await webrtc.createPeerConnection(
      config,
      //mediaConstraints,
    );

    return peerConnection;
  }

  @override
  void onClose() async {
    try {
      await _repository.disconnect();
      // Local stream'i durdur
      _localStream?.getTracks().forEach((track) {
        track.stop(); // Her bir track'i durdur
      });
      _localStream = null;

      // Renderer'ı temizle
      localRenderer.srcObject = null;
      await localRenderer.dispose();

      // PeerConnection'ları temizle
      pcs.forEach((key, val) async {
        await val.close();
        await val.dispose();
      });
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      WakelockPlus.disable();
    } catch (e) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      WakelockPlus.disable();
      exceptionHandle(e);
    }

    super.onClose();
  }
}
