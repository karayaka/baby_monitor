import 'package:baby_monitor/core/app_tools/ad_helper.dart';
import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/controllers/device_controller.dart';
import 'package:baby_monitor/data/repositorys/stream_repoistory.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ViewerController extends BaseController {
  late final StreamRepoistory _repository;
  late final String _deviceId;
  var remoteRenderer = webrtc.RTCVideoRenderer();
  var isConnect = 0.obs;
  webrtc.RTCPeerConnection? _peerConnection;
  late Map<String, dynamic> config;
  int rewordAdCounterSec = 10;
  //ads
  BannerAd? bottomBannerAd;
  var isBottomLoaded = false.obs;
  BannerAd? topBannerAd;
  var isTopAdLoaded = false.obs;
  bool _earnedReward = false;
  RewardedAd? _rewardedAd;
  InterstitialAd? _interstitialAd;

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
    _createBottomBannerAd();
    _createTopBannerAd();
    _loadRewardedAd();
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

  void answerCandidate(dynamic data) async {
    try {
      var candidate = data[1];
      final iceCandidate = webrtc.RTCIceCandidate(
        candidate['candidate'],
        candidate['sdpMid'],
        candidate['sdpMLineIndex'],
      );
      await _peerConnection!.addCandidate(iceCandidate);
      //isConnect.value = 1;
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
        isConnect.value = 1;
      }
    };
    return peerConnection;
  }

  _createBottomBannerAd() {
    bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdID,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isBottomLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    bottomBannerAd?.load();
  }

  _createTopBannerAd() {
    topBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdID,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isTopAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    topBannerAd?.load();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.viewerRewardedAdID,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void tickTriggedRewardedAd(int timerSec) {
    if (timerSec == 10 || (timerSec %= 90) == 0) {
      _showRewardedAd();
    }
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      return;
    }
    _earnedReward = false;
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        if (!_earnedReward) {
          Get.back();
        } else {
          succesMessage("mb075".tr);
          rewordAdCounterSec += 60;
        }
        ad.dispose();
        _loadRewardedAd(); // tekrar yükle
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        //Get.toNamed(RouteConst.streamerScrean);
        ad.dispose();
        _loadRewardedAd();
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        //ödül alındı sayfaya yürüt
        _earnedReward = true;
      },
    );

    _rewardedAd = null;
  }

  Future<void> _loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdID,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd!.show();
        },
        onAdFailedToLoad: (error) {
          if (_interstitialAd != null) {
            _interstitialAd!.dispose();
          }
        },
      ),
    );
  }

  @override
  void onClose() async {
    try {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      _loadInterstitialAd();
      // PeerConnection'ı kapat ve temizle
      await _peerConnection?.close();
      await _peerConnection?.dispose();
      _peerConnection = null;

      // Renderer'ı temizle
      await remoteRenderer.dispose();

      // SignalR bağlantısını kes
      await _repository.disconnect();

      WakelockPlus.disable();
      Get.find<DeviceController>().getDevices();

      super.onClose();
    } catch (e) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    await topBannerAd?.dispose();
    await bottomBannerAd?.dispose();
    await _rewardedAd?.dispose();
    await _interstitialAd?.dispose();
  }
}
