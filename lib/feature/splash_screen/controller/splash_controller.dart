import 'package:get/get.dart';

class SplashController extends GetxController {
  bool isLoading = true;

  var leftPosition = (-370.0).obs;
  var rightPosition = (370.0).obs;
  var topPosition = 0.4.obs;
  var dasTop = 2.0.obs;
  var opacityA = 0.0.obs;
  var opacityL = 1.0.obs;

  @override
  void onInit() {
    super.onInit();
    startAnimation();
  }

  void startAnimation() {
    Future.delayed(Duration(seconds: 3), () {
      leftPosition.value = 0;
      rightPosition.value = 0;

      Future.delayed(Duration(seconds: 2), () {
        // topPosition.value = 0;
        dasTop.value = 0;
        opacityA.value = 1;
        Future.delayed(Duration(seconds: 2), () {
          opacityL.value = 0;
        });
      });
    });
  }
}
