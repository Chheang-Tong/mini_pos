import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../feature.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              top: size.height * controller.topPosition.value,
              left: controller.leftPosition.value,
              right: controller.rightPosition.value,
              child: AnimatedOpacity(
                opacity: controller.opacityL.value,
                duration: Duration(milliseconds: 700),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 64),
                  width: size.width,
                  height: size.height * 0.2,
                  child: SvgPicture.asset('assets/images/logo.svg'),
                ),
              ),
            ),
          ),
          Obx(
            () => AnimatedOpacity(
              opacity: controller.opacityA.value,
              duration: Duration(milliseconds: 800),
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: AuthScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
