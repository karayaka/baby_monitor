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

  static String get appOpenAdID {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/9257395921'; //TODO test ıdler
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111'; //test ad kimliği ios app oluşturulmadı
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }

  static String get rewardedAdID {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; //TODO test ıdler
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111'; //test ad kimliği ios app oluşturulmadı
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }

  static String get viewerRewardedAdID {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; //TODO test ıdler
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111'; //test ad kimliği ios app oluşturulmadı
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }

  static String get streamerRewardedAdID {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; //TODO test ıdler
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111'; //test ad kimliği ios app oluşturulmadı
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }

  static String get interstitialAdID {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712'; //TODO test ıdler
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111'; //test ad kimliği ios app oluşturulmadı
    } else {
      throw UnsupportedError("unsupported platform");
    }
  }
}
