import 'package:baby_monitor/data/controllers/base_controller.dart';
import 'package:baby_monitor/data/repositorys/device_repository.dart';
import 'package:baby_monitor/models/device_models/device_list_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class DeviceController extends BaseController {
  late DeviceRepository _deviceRepository;
  var deviceList = <DeviceListModel>[].obs;
  var deviceListLoaing = false.obs;

  DeviceController() {
    _deviceRepository = Get.find();
    getDevices();
    //Get.find<SendNotifireRepoistory>().start();
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data['type'] == 'start_stream') getDevices();
    });
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
}
