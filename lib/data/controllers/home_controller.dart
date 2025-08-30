import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/device_repository.dart';
import 'package:baby_monitor/data/repositorys/family_repoistory.dart';
import 'package:baby_monitor/data/services/device_service.dart';
import 'package:baby_monitor/models/device_models/add_device_model.dart';
import 'package:baby_monitor/models/device_models/device_list_model.dart';
import 'package:baby_monitor/models/family_models/family_model.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeController extends BaseController {
  late DeviceRepository _deviceRepository;
  late FamilyRepoistory _familyRepoistory;
  var deviceList = <DeviceListModel>[].obs;
  var familyModel = FamilyModel().obs;
  var deviceListLoaing = false.obs;
  var addDeviceLoaing = false.obs;
  var familyLoading = false.obs;
  bool _earnedReward = false;
  //add obs
  AppOpenAd? _appOpenAd;
  var isAdLoaded = false.obs;
  BannerAd? bannerAd;
  RewardedAd? _rewardedAd;

  HomeController() {
    _deviceRepository = Get.find();
    _familyRepoistory = Get.find();
  }
  @override
  onInit() async {
    super.onInit();
    _loadAppOpenAd();
    _createBannerAd();
    _loadRewardedAd();
    addDevice();
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data['type'] == 'start_stream') getDevices();
    });
  }

  _createBannerAd() {
    bannerAd = BannerAd(
      adUnitId:
          "ca-app-pub-3940256099942544/9214589741", //TODO ADS banner ad ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    bannerAd?.load();
  }

  void _loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId:
          'ca-app-pub-3940256099942544/9257395921', //TODO ADS  Uygulama açılış reklam ID gelecek
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _showAdIfAvailable();
        },
        onAdFailedToLoad: (error) {
          print("AppOpenAd failed to load: $error");
        },
      ),
    );
  }

  void _showAdIfAvailable() {
    if (_appOpenAd == null) return;
    _appOpenAd!.show();
    _appOpenAd = null;
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId:
          "ca-app-pub-3940256099942544/5224354917", // //TODO ADS ödülüü reklam
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void showRewardedAd() {
    if (_rewardedAd == null) {
      //Get.toNamed(RouteConst.streamerScrean);
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        if (_earnedReward) {
          Get.toNamed(RouteConst.streamerScrean);
        } else {
          errorMessage("Uayrı");
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

  Future<bool> addDevice() async {
    try {
      if (!hasDeviceToken()) {
        addDeviceLoaing.value = true;
        String? token = await FirebaseMessaging.instance.getToken();
        //progres yeniden planlanacak
        addDeviceLoaing.value = true;
        var deviceModel = await DeviceService.instance.getDeviceInfo();
        var sesion = getSession();
        var addDeviceModel = AddDeviceModel(
          deviceBrand: deviceModel.brand,
          deviceName:
              "${sesion?.name ?? ""} ${sesion?.lastName ?? ""} - ${deviceModel.brand ?? " "} ${deviceModel.model ?? " "}",
          deviceToken: deviceModel.id,
          fcmToken: token,
          familyID: null,
          familyName: null,
        );
        var deviceId = prepareServiceModel<String>(
          await _deviceRepository.addDevice(addDeviceModel),
        );
        if (deviceId != null) {
          //yeni eklene devcice preferensis e ekleniyor
          setDeviceToken(deviceId);
          //bu cihaz cache ekleniypr
          await _deviceRepository.addThisDbDevice(addDeviceModel, deviceId);
        }
        addDeviceLoaing.value = false;
      }
      getDevices();
      getFamily();
    } catch (e) {
      exceptionHandle(e);
      addDeviceLoaing.value = false;
    }
    return true;
  }

  Future getDevices() async {
    try {
      //cachte olan listeey eklenik ekranda gösterliyor

      var devicChachListModel = await _deviceRepository.getDbDevices();

      if (devicChachListModel != null) {
        deviceList.addAll(devicChachListModel);
      }

      deviceListLoaing.value = true;
      //apiden güncel veri çekiliyor
      var devices = prepareServiceModel<List<DeviceListModel>>(
        await _deviceRepository.getDevices(),
      );
      //güncel vei ile ekran değiştiriliyor
      if (devices != null) {
        deviceList.clear();
        deviceList.addAll(devices);
        //Hesaptaki bütün deviceler ekleniyor
        await _deviceRepository.addOrUpdateDevices(devices, getDeviceToken());
      }
      deviceListLoaing.value = false;
    } catch (e) {
      deviceListLoaing.value = false;
      exceptionHandle(e);
    }
  }

  Future getFamily() async {
    try {
      var family = await _familyRepoistory.getDbFamily();
      if (family != null) {
        familyModel.value = family;
      }

      familyLoading.value = true;
      var fml = prepareServiceModel<FamilyModel>(
        await _familyRepoistory.getFamily(getSession()?.id ?? ""),
      );
      if (fml != null) {
        familyModel.value = fml;
        await _familyRepoistory.addOrUpdateFamily(fml);
      } else {
        await _familyRepoistory.clearFamily();
        familyModel.value = FamilyModel();
      }
      familyLoading.value = false;
    } catch (e) {
      familyLoading.value = false;
      exceptionHandle(e);
    }
  }

  bool hasStreamedDevice() => deviceList.any((t) => t.streamStatus == 1);

  Iterable<DeviceListModel> getStreamedDevices() =>
      deviceList.where((t) => t.streamStatus == 1);
  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }
}
