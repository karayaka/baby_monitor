import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/stream_repoistory.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;
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
    print("sdp cevap geldi");
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
    print("Candidate cevap geldi");
  }

  Future<webrtc.RTCPeerConnection> _createPeerConnection() async {
    final constraints = {'mandatory': {}, 'optional': []};

    final peerConnection = await webrtc.createPeerConnection(
      WebrtcConnectionConst.config,
      constraints,
    );

    // Remote track'leri dinle
    peerConnection.onTrack = (webrtc.RTCTrackEvent event) {
      print("Track received: ${event.track.id}");
      if (event.streams.isNotEmpty) {
        remoteRenderer.srcObject =
            event.streams[0]; // Remote renderer'a bağlanıyor
      }
    };

    return peerConnection;
  }

  // Remote description ayarla
  /* _repository.connect(onReceiveAnswer: (answer) async {
      print("Received answer: $answer");
      await _peerConnection!.setRemoteDescription(
        webrtc.RTCSessionDescription(answer['sdp'], answer['type']),
      );
    });

    // ICE candidate'leri al ve ekle
    _repository.connect(onReceiveIceCandidate: (candidate) async {
      print("Received ICE candidate: $candidate");
      final iceCandidate = webrtc.RTCIceCandidate(
        candidate['candidate'],
        candidate['sdpMid'],
        candidate['sdpMLineIndex'],
      );
      if (_peerConnection != null) {
        await _peerConnection!.addCandidate(iceCandidate);
      } else {
        _remoteCandidates.add(iceCandidate);
      }
    });*/

  @override
  void onClose() async {
    await _peerConnection?.close();
    _peerConnection = null;
    remoteRenderer.dispose();
    super.onClose();
  }
}
