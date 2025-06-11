import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/stream_repoistory.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class StreamerController extends BaseController {
  late final StreamRepoistory _repository;
  var isConnecting = false.obs;
  var msg = "".obs;
  webrtc.MediaStream? _localStream;
  final webrtc.RTCVideoRenderer localRenderer = webrtc.RTCVideoRenderer();
  Map<String, webrtc.RTCPeerConnection> pcs = {};
  StreamerController() {
    _repository = Get.find();
  }

  @override
  void onReady() async {
    isConnecting.value = true;
    await _repository.connect(
      sendOffer: sendOffer,
      sendCandidate: sendCandidate,
    );
    await _requestPermissions();
    await _startStream();
    isConnecting.value = false;
    super.onReady();
  }

  Future<void> _startStream() async {
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
        'width': 800,
        'height': 480,
        'frameRate': 15,
      },
    });

    localRenderer.srcObject = _localStream;
    await _repository.sendStartStreamNotification("mb006".tr, "mb007".tr);
  }

  Future<void> callOthers() async {
    await _repository.callOtherDevice("deviceName");
  }

  ///İzleyiciden gelen offerler işlenecek
  void sendOffer(dynamic data) async {
    final pc = await _createPeerConnection();

    pc.onConnectionState = (state) async {
      print("[$data[0]] PeerConnection State: $state");
      if (state == webrtc.RTCPeerConnectionState.RTCPeerConnectionStateFailed ||
          state ==
              webrtc
                  .RTCPeerConnectionState
                  .RTCPeerConnectionStateDisconnected ||
          state == webrtc.RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
        await pc.close();
        pcs.remove(data[0]);
        print("[$data[0]] PeerConnection closed and removed.");
      }
    };

    //local stream veri setine eklenyor
    _localStream?.getTracks().forEach((track) {
      pc.addTrack(track, _localStream!);
    });
    pc.onIceCandidate = (candidate) {
      print("candidatedatası: ${candidate.toMap()}");
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
  }

  ///İzleyiciden gelen Candidateler işelenecek
  void sendCandidate(dynamic data) async {
    //Hubdan glen candiateler bu şekile ekleniyor

    await pcs[data[0]]?.addCandidate(
      webrtc.RTCIceCandidate(
        data[1]['candidate'],
        data[1]['sdpMid'],
        data[1]['sdpMLineIndex'],
      ),
    );
  }

  @override
  void onClose() async {
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
    super.onClose();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();
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
      'iceServers': WebrtcConnectionConst.iceService,
      'iceTransportPolicy': 'relay', // Sadece TURN kullan
      'sdpSemantics': 'unified-plan',
      'bundlePolicy': 'max-bundle', // DTLS sorununu azaltır
      'rtcpMuxPolicy': 'require',
    };
    final peerConnection = await webrtc.createPeerConnection(
      WebrtcConnectionConst.config,
      mediaConstraints,
    );

    return peerConnection;
  }
}
