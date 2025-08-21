import 'package:flutter/material.dart';
import 'package:cagnaz_apps/cagnaz_apps.dart';

class AppsPage extends StatelessWidget {
  const AppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CagnazApps(
      appName: "İngilizce Sorular",
      desc:
          "İngilizce Sorular uygulaması, dil öğrenmenin en kolay yolu. Ücretsiz, hızlı ve eğlenceli ! İngilizce öğrenemiyorum, kelime haznem yetersiz, İngilizce dil bilgisi konusunda pratik yapabileceğim bir uygulama arıyorum diyorsanız, İngilizce Sorular uygulaması, hepsini bir arada bulunduran bir uygulamadır",
    );
  }
}
