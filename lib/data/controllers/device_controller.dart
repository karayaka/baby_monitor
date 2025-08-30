import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/device_repository.dart';
import 'package:baby_monitor/models/device_models/device_list_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DeviceController extends BaseController {
  late DeviceRepository _deviceRepository;
  var deviceList = <DeviceListModel>[].obs;
  var deviceListLoaing = false.obs;
  BannerAd? bottomBannerAd;
  var isBottomLoaded = false.obs;
  BannerAd? topBannerAd;
  var isTopAdLoaded = false.obs;

  DeviceController() {
    _deviceRepository = Get.find();
    getDevices();
    //Get.find<SendNotifireRepoistory>().start();
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data['type'] == 'start_stream') getDevices();
    });
  }
  @override
  onInit() async {
    super.onInit();
    _createBottomBannerAd();
    _createTopBannerAd();
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data['type'] == 'start_stream') getDevices();
    });
  }

  _createBottomBannerAd() {
    bottomBannerAd = BannerAd(
      adUnitId:
          "ca-app-pub-3940256099942544/9214589741", //TODO ADS banner ad ID
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
      adUnitId:
          "ca-app-pub-3940256099942544/9214589741", //TODO ADS banner ad ID
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

  Future getDevices() async {
    try {
      //cachte olan listeey eklenik ekranda gösterliyor
      deviceList.clear();
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
        await _deviceRepository.addOrUpdateDevices(
          deviceList,
          getDeviceToken(),
        );
      }
      deviceListLoaing.value = false;
    } catch (e) {
      deviceListLoaing.value = false;
      exceptionHandle(e);
    }
  }

  Future deleteDevice(String deviceId) async {
    try {
      if (deviceId == getDeviceToken()) {
        Get.back();
        errorMessage("Şuan Kullandığınız Çihazı Silemezsiniz");
        return;
      }
      deviceListLoaing.value = true;
      prepareServiceModel<int>(await _deviceRepository.deleteDevice(deviceId));
      await _deviceRepository.deleteDeviceFromDb(deviceId);
      getDevices();
      deviceListLoaing.value = false;
    } catch (e) {
      deviceListLoaing.value = false;
      exceptionHandle(e);
    }
    Get.back();
  }

  Future refreshDevice() async {
    try {
      deviceListLoaing.value = true;
      prepareServiceModel<bool>(
        await _deviceRepository.refreshDevice(getSession()?.id ?? ""),
      );

      getDevices();
      deviceListLoaing.value = false;
    } catch (e) {
      deviceListLoaing.value = false;
      exceptionHandle(e);
    }
  }

  Future sendNotifire() async {
    //Get.find<SendNotifireRepoistory>().sendNotifire();
  }

  //sadece kendi çihazlarını silebilir
  bool canDeleteDevice(String userId) => userId == getSession()?.id;
  //live stream bilgilri varken izleme yapabilir
  bool showWatchButon(String deviceId) =>
      deviceList.any((d) => d.id == deviceId && d.streamStatus == 1);
  @override
  void dispose() {
    if (bottomBannerAd != null) {
      bottomBannerAd!.dispose();
    }
    if (topBannerAd != null) {
      topBannerAd!.dispose();
    }
    super.dispose();
  }
}
