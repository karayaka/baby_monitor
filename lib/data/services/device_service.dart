import 'dart:io';
import 'package:baby_monitor/models/device_models/device_info_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceService {
  static DeviceService? _instance;
  static DeviceService get instance => _instance ??= DeviceService();

  Future<DeviceInfoModel> getDeviceInfo() async {
    var deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var inf = await deviceInfoPlugin.androidInfo;
      return DeviceInfoModel(
          brand: inf.brand, model: inf.model, id: await _getPersistentUUID());
    } else {
      var inf = await deviceInfoPlugin.iosInfo;
      return DeviceInfoModel(
          brand: inf.name, model: inf.model, id: inf.identifierForVendor);
    }
  }

  Future<String> _getPersistentUUID() async {
    const storage = FlutterSecureStorage();

    // Daha önce kaydedilmiş ID'yi kontrol et
    String? storedId = await storage.read(key: 'device_id');

    if (storedId == null) {
      // Yeni bir UUID oluştur
      storedId = const Uuid().v4();

      // UUID'yi güvenli bir şekilde sakla
      await storage.write(key: 'device_id', value: storedId);
    }

    return storedId;
  }
}
