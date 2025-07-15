import 'package:get/get.dart';

import '../../feature/feature.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String welcomeScreen = "/welcome_screen";
  static const String navbarScreen = "/navbar_screen";
  static const String posScreen = "/pos_screen";
  static const String cartScreen = "/cart_screen";
  static const String scanScreen = "/scan_screen";
  static const String orderScreen = "/order_screen";
  static const String profileUpdate = "/profile_update";
  static const String resetScreen = "/reset_screen";
  static const String authScreen = "/auth_screen";
  static const String resetPWScreen = '/reset_password';

  List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: authScreen, page: () => const AuthScreen()),
    GetPage(name: welcomeScreen, page: () => const WelcomeScreen()),
    GetPage(name: navbarScreen, page: () => const NavbarScreen()),
    GetPage(name: scanScreen, page: () => ScanScreen()),
    GetPage(name: profileUpdate, page:()=>ProfileUpdate()),
    GetPage(name: resetPWScreen, page:()=>ResetPassword()),
  ];
}
