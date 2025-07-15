import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Map<String, String> langItems = {
    'English': 'assets/images/usa_flag.jpg',
    'Khmer': 'assets/images/cambodia_flag.jpg',
  };

  int selectedLangIndex = 0;
  onLang(int index) {
    selectedLangIndex = index;
    update();
  }
}
