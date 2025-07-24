import 'package:get/get.dart';
import 'package:minipos_app/core/core.dart';

Future<Map<String,Map<String,String>>>init() async {
  Get.lazyPut(()=>ApiService());

  Map<String,Map<String,String>>language={};
  language['en_US']={'':''};
  return language;
}