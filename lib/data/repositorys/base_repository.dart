import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:get_storage/get_storage.dart';

class BaseRepository {
  String? getToken() {
    final box = GetStorage();
    return box.read(ProjectConst.SESSION_CONTS);
  }
}
