import 'package:get/utils.dart';

class ProjectValidations {
  static String? notEmty(val) {
    if (val == null || val.trim().isEmpty) {
      return 'mb029'.tr;
    }
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'mb029'.tr;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'mb066'.tr;
    return null;
  }
}
