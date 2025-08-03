import 'package:baby_monitor/core/app_tools/baby_monitor_translations.dart';
import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/core/app_tools/theme.dart';
import 'package:baby_monitor/data/bindings/initial_bindings/initial_binding.dart';
import 'package:baby_monitor/data/services/fcm_callkit_service.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/routing/route_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Eğer bildirim bir çağrı içeriyorsa
  if (message.data['type'] == 'call') {
    await FcmCallkitService.showIncomingCall(message);
  } else {
    await FcmCallkitService.showNotification(message);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FcmCallkitService.initialize();
  await GetStorage.init();
  await Hive.initFlutter();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      locale: ProjectConst.getLocale(),
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.light,
    );
  }
}
//TODO keytool password Kara.531531

//TODO app id dart run change_app_package_name:main com.cagnaz.babymonitor

//TODO paketleri lates e çek ve güncellemeyi dene yedeklendi !
