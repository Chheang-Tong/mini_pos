import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minipos_app/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      initialRoute: RouteHelper.splashScreen,
      navigatorKey: Get.key,
      getPages: RouteHelper().routes,

      // translations: Messages(languages: {}),
      // fallbackLocale: Locale(
      //   localizationController.locale.languageCode,
      //   localizationController.locale.countryCode,
      // ),
    );
  }
}
