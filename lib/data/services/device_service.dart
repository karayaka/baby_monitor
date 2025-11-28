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
        brand: inf.brand,
        model: inf.model,
        id: await _getPersistentUUID(),
      );
    } else {
      var inf = await deviceInfoPlugin.iosInfo;
      return DeviceInfoModel(
        brand: inf.name,
        model: inf.model,
        id: inf.identifierForVendor,
      );
    }
  }

  Future<String> _getPersistentUUID() async {
    const storage = FlutterSecureStorage();

    try {
      String? deviceId = await storage.read(key: 'device_id');

      if (deviceId == null) {
        deviceId = const Uuid().v4();
        await storage.write(key: 'device_id', value: deviceId);
      }

      return deviceId;
    } catch (e) {
      // BAD_DECRYPT oldugunda secure-storage bozulmus demektir
      await storage.deleteAll();

      final newId = const Uuid().v4();
      await storage.write(key: 'device_id', value: newId);
      return newId;
    }
  }
}
