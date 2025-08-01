import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/controllers/device_controller.dart';
import 'package:baby_monitor/data/repositorys/stream_repoistory.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ViewerController extends BaseController {
  late final StreamRepoistory _repository;
  late final String _deviceId;
  final webrtc.RTCVideoRenderer remoteRenderer = webrtc.RTCVideoRenderer();
  var isConnect = 0.obs;
  var showAdd = false.obs;
  webrtc.RTCPeerConnection? _peerConnection;
  late Map<String, dynamic> config;
  ViewerController() {
    _repository = Get.find();
    _deviceId = Get.arguments['deviceId'];
  }
  @override
  void onReady() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.onReady();
    WakelockPlus.enable();
    config = await _repository.fetchIceServers();
    await _repository.connect(
      answerOffer: answerOffer,
      answerCandidate: answerCandidate,
    );
    await remoteRenderer
        .initialize(); // Remote renderer'ı başlat ekranda göstermek için algoritma düşünelecek
    await _initializeConnection();
  }

  Future<void> _initializeConnection() async {
    try {
      // PeerConnection oluştur
      _peerConnection = await _createPeerConnection();
      _peerConnection?.onConnectionState = (state) {
        if (state ==
                webrtc.RTCPeerConnectionState.RTCPeerConnectionStateFailed ||
            state ==
                webrtc
                    .RTCPeerConnectionState
                    .RTCPeerConnectionStateDisconnected ||
            state ==
                webrtc.RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
          isConnect.value = 2;
        }
      };

      // Local offer oluştur ve SignalR üzerinden gönder
      final offer = await _peerConnection!.createOffer();
      await _peerConnection!.setLocalDescription(offer);

      await _repository.sendtoCliend(
        _deviceId,
        HubMethods.sendOffer,
        offer.toMap(),
      );

      // Remote ICE candidate'leri ekle
      _peerConnection!.onIceCandidate = (candidate) {
        _repository.sendtoCliend(
          _deviceId,
          HubMethods.sendCandidate,
          candidate.toMap(),
        );
      };
    } catch (e) {
      exceptionHandle(e);
    }
  }

  void answerOffer(dynamic data) async {
    try {
      var answer = data[1];
      await _peerConnection!.setRemoteDescription(
        webrtc.RTCSessionDescription(answer['sdp'], answer['type']),
      );
    } catch (e) {
      exceptionHandle(e);
    }
  }

  void answerCandidate(dynamic data) async {
    try {
      var candidate = data[1];
      final iceCandidate = webrtc.RTCIceCandidate(
        candidate['candidate'],
        candidate['sdpMid'],
        candidate['sdpMLineIndex'],
      );
      await _peerConnection!.addCandidate(iceCandidate);
      isConnect.value = 1;
    } catch (e) {
      exceptionHandle(e);
    }
  }

  Future<webrtc.RTCPeerConnection> _createPeerConnection() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'mandatory': {
          'maxWidth': '320',
          'maxHeight': '240',
          'maxFrameRate': '10',
        },
        'facingMode': 'user',
        'optional': [],
      },
    };

    final peerConnection = await webrtc.createPeerConnection(
      config,
      mediaConstraints,
    );

    // Remote track'leri dinle
    peerConnection.onTrack = (webrtc.RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        remoteRenderer.srcObject =
            event.streams[0]; // Remote renderer'a bağlanıyor
      }
    };
    return peerConnection;
  }

  @override
  void onClose() async {
    try {
      // PeerConnection'ı kapat ve temizle
      await _peerConnection?.close();
      _peerConnection = null;

      // Renderer'ı temizle
      await remoteRenderer.dispose();

      // SignalR bağlantısını kes
      await _repository.disconnect();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      WakelockPlus.disable();
      Get.find<DeviceController>().getDevices();
    } catch (e) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    super.onClose();
  }
}
