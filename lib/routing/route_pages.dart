import 'package:baby_monitor/data/bindings/device_bindings/device_binding.dart';
import 'package:baby_monitor/data/bindings/family_bindings/family_binding.dart';
import 'package:baby_monitor/data/bindings/home_bindings/home_bindings.dart';
import 'package:baby_monitor/data/bindings/profile_bindings/profile_binding.dart';
import 'package:baby_monitor/data/bindings/securty_bindings/securty_binding.dart';
import 'package:baby_monitor/data/bindings/splash_bindings/splash_binding.dart';
import 'package:baby_monitor/data/bindings/streamer_bindings/streamer_binding.dart';
import 'package:baby_monitor/data/bindings/viewer_bindings/viewer_binding.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/views/pages/device_pages/device_page.dart';
import 'package:baby_monitor/views/pages/family_pages/family_page.dart';
import 'package:baby_monitor/views/pages/family_pages/layouts/join_family_layout.dart';
import 'package:baby_monitor/views/pages/home/home_page.dart';
import 'package:baby_monitor/views/pages/profile_pages/profile_page.dart';
import 'package:baby_monitor/views/pages/security_pages/security_page.dart';
import 'package:baby_monitor/views/pages/splash_pages/splash_page.dart';
import 'package:baby_monitor/views/pages/streamer_pages/streamer_page.dart';
import 'package:baby_monitor/views/pages/viewer_pages/viewer_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class RoutePages {
  static final Transition _transition = Transition.rightToLeft;
  static final Transition _popuptransition = Transition.downToUp;
  static final pages = [
    GetPage(
      name: RouteConst.splashScrean,
      page: () => SplashPage(),
      transition: _transition,
      binding: SplashBinding(),
    ),
    GetPage(
      name: RouteConst.home,
      page: () => HomePage(),
      transition: _transition,
      binding: HomeBindings(),
    ),
    GetPage(
      name: RouteConst.security,
      page: () => SecurityPage(),
      transition: _transition,
      binding: SecurtyBinding(),
    ),
    GetPage(
      name: RouteConst.familyList,
      page: () => FamilyPage(),
      transition: _transition,
      binding: FamilyBinding(),
    ),
    GetPage(
      name: RouteConst.deviceList,
      page: () => DevicePage(),
      transition: _transition,
      binding: DeviceBinding(),
    ),
    GetPage(
      name: RouteConst.joinFamilyLayout,
      fullscreenDialog: true,
      page: () => JoinFamilyLayout(),
      transition: _popuptransition,
    ),
    GetPage(
      name: RouteConst.streamerScrean,
      fullscreenDialog: true,
      page: () => StreamerPage(),
      transition: _popuptransition,
      binding: StreamerBinding(),
    ),
    GetPage(
      name: RouteConst.viewerScrean,
      page: () => ViewerPage(),
      transition: _transition,
      binding: ViewerBinding(),
    ),
    GetPage(
      name: RouteConst.profile,
      fullscreenDialog: true,
      page: () => ProfilePage(),
      transition: _popuptransition,
      binding: ProfileBinding(),
    ),
  ];
}
