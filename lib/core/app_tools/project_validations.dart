import 'package:get/utils.dart';

class ProjectValidations {
  static String? notEmty(val) {
    if (val == null || val.trim().isEmpty) {
      return 'Bu Alan boş olamaz'.tr;
    }
  }
}
