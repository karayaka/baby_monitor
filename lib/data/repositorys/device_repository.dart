import 'package:baby_monitor/data/local_storage/device_db_manager.dart';
import 'package:baby_monitor/data/local_storage/storage_models/device_storage_model.dart';
import 'package:baby_monitor/data/repositorys/base_repository.dart';
import 'package:baby_monitor/data/services/http_service.dart';
import 'package:baby_monitor/models/base_models/base_result.dart';
import 'package:baby_monitor/models/device_models/add_device_model.dart';
import 'package:baby_monitor/models/device_models/device_list_model.dart';
import 'package:baby_monitor/models/device_models/refresh_FCM_Token_Model.dart';

class DeviceRepository extends BaseRepository {
  late HttpService _service;
  late DeviceDbManager _dbManager;
  DeviceRepository() {
    _service = HttpService.instance!;
    _dbManager = DeviceDbManager();
  }
  //AddDeviceModel
  Future<BaseResult> addDevice(AddDeviceModel model) async {
    try {
      return await _service.post(
        "babymonitor//Device/AddDevice",
        null,
        model,
        token: getToken(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> getDevices() async {
    try {
      return await _service.get(
        "babymonitor/Device/GetDevices",
        DeviceListModel(),
        token: (getToken() ?? ""),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> addThisDbDevice(AddDeviceModel model, String deviceId) async {
    try {
      await _dbManager.init();
      return await _dbManager.addOrUpdateDevice(
        DeviceStorageModel(
          familyID: model.familyID,
          familyName: model.familyName,
          deviceBrand: model.deviceBrand,
          deviceId: deviceId,
          deviceToken: model.deviceToken,
          deviceName: model.deviceName,
          isThisDevice: true,
          fcmToken: model.fcmToken,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future deleteDeviceFromDb(String deviceId) async {
    try {
      await _dbManager.init();
      _dbManager.removeItemByQuery((q) => q?.deviceId == deviceId);
    } catch (e) {
      rethrow;
    }
  }

  Future addOrUpdateDevices(
    List<DeviceListModel> devices,
    String? thsDeviceid,
  ) async {
    try {
      await _dbManager.init();
      for (var device in devices) {
        await _dbManager.addOrUpdateDevice(
          DeviceStorageModel(
            familyID: device.familyID,
            familyName: device.familyName,
            deviceBrand: device.deviceBrand,
            deviceId: device.id,
            deviceToken: device.deviceToken,
            deviceName: device.deviceName,
            isThisDevice: device.id == thsDeviceid,
            fcmToken: device.fcmToken,
            iceCandidate: device.iceCandidate,
            userID: device.userID,
            userName: device.userName,
            userSurname: device.userSurname,
            sd: device.sd,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DeviceListModel>?> getDbDevices() async {
    try {
      await _dbManager.init();
      return _dbManager
          .getAllValues()
          ?.map((d) => DeviceListModel().fromDeviceStorageMoel(d))
          .cast<DeviceListModel>()
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> deleteDevice(String deviceId) async {
    try {
      return await _service.get(
        "babymonitor/Device/DeleteDevice/$deviceId",
        null,
        token: (getToken() ?? ""),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> refreshDevice(String userId) async {
    try {
      return await _service.get(
        "babymonitor/Device/RefresDeviceFamily/$userId",
        null,
        token: (getToken() ?? ""),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> refreshFcmDevices(RefreshFcmTokenModel model) async {
    try {
      return await _service.post(
        "babymonitor/Device/SetDeviceFCMToken/",
        null,
        model,
        token: (getToken() ?? ""),
      );
    } catch (e) {
      rethrow;
    }
  }
}
