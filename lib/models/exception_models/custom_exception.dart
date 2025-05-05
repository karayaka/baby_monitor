import 'package:get/get.dart';

class CustomException implements Exception {
  final String message;
  CustomException([String message = ""])
      : message = message.isEmpty ? "Bir Hata Oluştu.".tr : message;
}
