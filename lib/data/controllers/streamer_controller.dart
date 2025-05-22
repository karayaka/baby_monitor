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
    //await _repository.sendStartStreamNotification("deneme1".tr, "body".tr);

    await _requestPermissions();
    await _initRendererAndStream();
    await _startStream();
    isConnecting.value = false;
    super.onReady();
  }

  Future<void> _initRendererAndStream() async {}

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
  }

  Future<void> disconnect() async {
    await _repository.disconnect();
  }

  Future<void> callOthers() async {
    await _repository.callOtherDevice("deviceName");
  }

  Future<void> sendToCliend() async {
    await _repository.sendtoCliend("", "", "");
  }

  ///İzleyiciden gelen offerler işlenecek
  void sendOffer(dynamic data) async {
    print(data[0]); //deviceID
    print(data[1]); //data map türünde
    print(data.runtimeType);
    final pc = await _createPeerConnection();
    //local stream veri setine eklenyor
    pc.addStream(_localStream!); // yayın akışı

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
    localRenderer.srcObject = null;
    await localRenderer.dispose();
    if (_localStream != null) await _localStream!.dispose();
    pcs.forEach((key, val) async {
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
    final constraints = {'mandatory': {}, 'optional': []};

    final peerConnection = await webrtc.createPeerConnection(
      WebrtcConnectionConst.config,
      constraints,
    );

    return peerConnection;
  }
}

/* incleme iyice oku çünkü farklı bir durum var----------------------

hubConnection.on("offer", (args) async {
  String fromId = args![0];
  Map offer = args[1];

  // PeerConnection oluştur
  RTCPeerConnection pc = await createPeerConnection({...});
  pc.addStream(localMediaStream); // yayın akışı

  pc.onIceCandidate = (candidate) {
    hubConnection.invoke("SendSignal", args: [
      {
        "type": "ice-candidate",
        "to": fromId,
        "data": candidate.toMap()
      }
    ]);
  };

  await pc.setRemoteDescription(RTCSessionDescription(
    offer["sdp"], offer["type"]
  ));

  RTCSessionDescription answer = await pc.createAnswer();
  await pc.setLocalDescription(answer);

  // Yanıtı geri gönder
  hubConnection.invoke("SendSignal", args: [
    {
      "type": "answer",
      "to": fromId,
      "data": answer.toMap()
    }
  ]);

  // Bağlantıyı sakla
  peerConnections[fromId] = pc;
});


*/
