import 'package:get/get.dart';
import 'package:minipos_app/core/core.dart';
import 'package:minipos_app/feature/cart/cart.dart';
import 'package:minipos_app/feature/product/product.dart'; // if needed
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences, fenix: true);

  // Core services
  Get.lazyPut(() => ApiService(sharedPreferences: Get.find()), fenix: true);

  // Repositories
  Get.lazyPut(() => CartRepo(apiService: Get.find()), fenix: true);
  Get.lazyPut(() => ProductRepo(apiService: Get.find()), fenix: true);

  // Controllers
  Get.lazyPut(() => CartController(cartRepo: Get.find()), fenix: true);
  // If needed: Get.lazyPut(() => ProductController(productRepo: Get.find()), fenix: true);

  // Language map
  Map<String, Map<String, String>> language = {};
  language['en_US'] = {'': ''};
  return language;
}
