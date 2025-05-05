import 'package:baby_monitor/data/bindings/device_bindings/device_binding.dart';
import 'package:baby_monitor/data/bindings/family_bindings/family_binding.dart';
import 'package:baby_monitor/data/bindings/home_bindings/home_bindings.dart';
import 'package:baby_monitor/data/bindings/securty_bindings/securty_binding.dart';
import 'package:baby_monitor/data/bindings/splash_bindings/splash_binding.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/views/pages/device_pages/device_page.dart';
import 'package:baby_monitor/views/pages/family_pages/family_page.dart';
import 'package:baby_monitor/views/pages/family_pages/layouts/join_family_layout.dart';
import 'package:baby_monitor/views/pages/home/home_page.dart';
import 'package:baby_monitor/views/pages/home/layouts/stream_layout.dart';
import 'package:baby_monitor/views/pages/security_pages/security_page.dart';
import 'package:baby_monitor/views/pages/splash_pages/splash_page.dart';
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
        binding: SplashBinding()),
    GetPage(
        name: RouteConst.home,
        page: () => HomePage(),
        transition: _transition,
        binding: HomeBindings()),
    GetPage(
        name: RouteConst.security,
        page: () => SecurityPage(),
        transition: _transition,
        binding: SecurtyBinding()),
    GetPage(
        name: RouteConst.familyList,
        page: () => FamilyPage(),
        transition: _transition,
        binding: FamilyBinding()),
    GetPage(
        name: RouteConst.deviceList,
        page: () => DevicePage(),
        transition: _transition,
        binding: DeviceBinding()),
    GetPage(
      name: RouteConst.joinFamilyLayout,
      fullscreenDialog: true,
      page: () => JoinFamilyLayout(),
      transition: _popuptransition,
    ),
    GetPage(
      name: RouteConst.streamLayout,
      fullscreenDialog: true,
      page: () => StreamLayout(),
      transition: _popuptransition,
    )
  ];
}
