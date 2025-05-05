import 'package:baby_monitor/core/app_tools/baby_monitor_translations.dart';
import 'package:baby_monitor/core/app_tools/theme.dart';
import 'package:baby_monitor/data/bindings/initial_bindings/initial_binding.dart';
import 'package:baby_monitor/firebase_options.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/routing/route_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baby Monitor',
      initialBinding: InitialBinding(),
      getPages: RoutePages.pages,
      translations: BabyMonitorTranslations(),
      initialRoute: RouteConst.splashScrean,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
//TODO keytool password Kara.531531

//TODO app id dart run change_app_package_name:main com.cagnaz.babymonitor
