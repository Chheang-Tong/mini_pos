import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../feature.dart';
import '../../../core/core.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});
  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final NavbarController navbarController = Get.put(NavbarController());

  @override
  void initState() {
    super.initState();
    //Make it Get to Orer Screen
    Future.delayed(Duration.zero, () {
      final int? initialIndex = Get.arguments as int?;
      if (initialIndex != null) {
        navbarController.changeIndex(initialIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<NavbarController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black12,
          body: controller.screens[controller.selectedIndex],
          extendBody: true,
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 26),
            height: 86,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: ColorResources.whiteColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                icButon(
                  iconPath: 'assets/images/product.svg',
                  title: 'Product',
                  index: 0,
                  controller: controller,
                ),
                icButon(
                  iconPath: 'assets/images/cart.svg',
                  title: 'Cart',
                  index: 1,
                  controller: controller,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.scanScreen),
                  child: Container(
                    height: 44,
                    width: 44,
                    margin: EdgeInsets.only(top: 17, bottom: 25),
                    decoration: BoxDecoration(
                      color: ColorResources.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/scan.svg',
                        color: ColorResources.whiteColor,
                      ),
                    ),
                  ),
                ),
                icButon(
                  iconPath: 'assets/images/order.svg',
                  title: 'Order',
                  index: 2,
                  controller: controller,
                ),
                icButon(
                  iconPath: 'assets/images/profile.svg',
                  title: 'Profile',
                  index: 3,
                  controller: controller,
                ),
              ],
            ),
           ),
        );
      },
    );
  }

  icButon({
    required String iconPath,
    required String title,
    required int index,
    required NavbarController controller,
  }) {
    final bool isSelected = controller.selectedIndex == index;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorResources.transparentColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                iconPath,
                color: isSelected
                    ? ColorResources.primaryColor
                    : ColorResources.darkColor,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: mediumDefault.copyWith(
                color: isSelected
                    ? ColorResources.primaryColor
                    : ColorResources.dark75,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
