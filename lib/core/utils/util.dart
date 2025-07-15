
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';

class MyUtils {
  static splashScreenUtils(bool isDark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // statusBarColor: ColorResources.getScreenBgColor(),
        statusBarIconBrightness: Brightness.light,
        // systemNavigationBarColor: ColorResources.getScreenBgColor(),
        systemNavigationBarIconBrightness: Brightness.light));
  }

  static void allScreensUtils(bool isDark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorResources.getPrimaryColor(),
        statusBarIconBrightness: Brightness.light,
        // systemNavigationBarColor: ColorResources.getScreenBgColor(),
        systemNavigationBarIconBrightness: Brightness.light));
  }

  static dynamic getShadow() {
    return [
      BoxShadow(
          blurRadius: 15.0,
          offset: const Offset(0, 25),
          color: Colors.grey.shade500.withValues(alpha: 0.6),
          spreadRadius: -35.0),
    ];
  }

  static dynamic getBottomSheetShadow() {
    return [
      BoxShadow(
        // color: Get.find<ThemeController>().darkTheme
        //     ? Colors.black87.withValues(alpha: 0.30)
        //     : Colors.grey.shade400.withValues(alpha: 0.30),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ];
  }

  static dynamic getCardShadow(BuildContext context) {
    return [
      BoxShadow(
        // color: Get.find<ThemeController>().darkTheme
        //     ? Theme.of(context).shadowColor.withValues(alpha: 0.10)
        //     : Colors.grey.shade400.withValues(alpha: 0.30),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ];
  }
}
