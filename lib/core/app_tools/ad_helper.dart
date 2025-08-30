import 'dart:io';

class AdHelper {
  static String get bannerAdID {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/9214589741'; //TODO test ıdler
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111'; //test ad kimliği ios app oluşturulmadı
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }
}
