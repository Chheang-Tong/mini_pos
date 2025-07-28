import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../feature.dart';

class NavbarController extends GetxController {
  int selectedIndex = 0;
  List<Widget> screens = [
    const ProScreen(),
    const CartScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    update();
  }
}
