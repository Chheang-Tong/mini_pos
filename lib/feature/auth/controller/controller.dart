import 'package:get/get.dart';

class AuthController extends GetxController {
  bool isLoading = true;
  @override
  void onInit() {
    super.onInit();
    login();
  }

  void login() {
    Future.delayed(Duration(milliseconds: 500), () {
      update();
    });
  }
}
