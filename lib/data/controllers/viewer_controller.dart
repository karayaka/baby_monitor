import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/stream_repoistory.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

class ViewerController extends BaseController {
  //viewer işlemşeri signalr bağlantıları yapılaca
  late final StreamRepoistory _repository;
  late final String _deviceId;
  final webrtc.RTCVideoRenderer remoteRenderer = webrtc.RTCVideoRenderer();
  var isConnect = false.obs;
  webrtc.RTCPeerConnection? _peerConnection;
  ViewerController() {
    _repository = Get.find();
    _deviceId = Get.arguments['deviceId'];
  }
  @override
  void onReady() async {
    super.onReady();
    await _repository.connect(
      answerOffer: answerOffer,
      answerCandidate: answerCandidate,
    );
    await remoteRenderer
        .initialize(); // Remote renderer'ı başlat ekranda göstermek için algoritma düşünelecek
    await _initializeConnection();
  }

  Future<void> _initializeConnection() async {
    // PeerConnection oluştur
    _peerConnection = await _createPeerConnection();

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
  }

  void answerOffer(dynamic data) async {
    var answer = data[1];
    await _peerConnection!.setRemoteDescription(
      webrtc.RTCSessionDescription(answer['sdp'], answer['type']),
    );
  }

  void answerCandidate(dynamic data) async {
    var candidate = data[1];
    final iceCandidate = webrtc.RTCIceCandidate(
      candidate['candidate'],
      candidate['sdpMid'],
      candidate['sdpMLineIndex'],
    );
    await _peerConnection!.addCandidate(iceCandidate);
    isConnect.value = true;
  }

  Future<webrtc.RTCPeerConnection> _createPeerConnection() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'mandatory': {
          'minWidth': '640',
          'minHeight': '360',
          'minFrameRate': '7',
        },
        'facingMode': 'user',
        'optional': [],
      },
    };
    final configuration = {
      'iceServers': WebrtcConnectionConst.config,
      'iceTransportPolicy': 'relay', // Sadece TURN kullan
    };
    final peerConnection = await webrtc.createPeerConnection(
      WebrtcConnectionConst.config,
      mediaConstraints,
    );

    // Remote track'leri dinle
    peerConnection.onTrack = (webrtc.RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        remoteRenderer.srcObject =
            event.streams[0]; // Remote renderer'a bağlanıyor
      }
    };

    peerConnection.onIceConnectionState = (state) {
      print("ICE Connection State: $state");
      if (state == RTCIceConnectionState.RTCIceConnectionStateFailed) {
        // ICE bağlantısı başarısız oldu
      }
      var reports = peerConnection.getStats().then((stats) {
        for (var stater in stats) {
          print("ICE Connection report: ${stater.values}");
        }
      });
      print(peerConnection.getStats());
    };

    return peerConnection;
  }

  @override
  void onClose() async {
    // PeerConnection'ı kapat ve temizle
    await _peerConnection?.close();
    _peerConnection = null;

    // Renderer'ı temizle
    remoteRenderer.srcObject = null;
    await remoteRenderer.dispose();

    // SignalR bağlantısını kes
    await _repository.disconnect();

    super.onClose();
  }
}
