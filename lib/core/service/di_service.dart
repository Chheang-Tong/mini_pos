import 'package:get/get.dart';
import 'package:minipos_app/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String,Map<String,String>>>init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(()=>ApiService(sharedPreferences: Get.find()));

  Map<String,Map<String,String>>language={};
  language['en_US']={'':''};
  return language;
}