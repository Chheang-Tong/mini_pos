import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  int qty = 1;
  final TextEditingController searchController = TextEditingController(),
      discountCtr = TextEditingController();
  int discountIndex = 0, methodIndex = 0;
  Map<String, String> discount = {
    "assets/images/dolar.svg": "Fix Discount",
    "assets/images/percent.svg": "Percentage",
  };
  Map<String, String> method = {
    "assets/images/cash.svg": "Cash",
    "assets/images/bank.svg": "Bank",
  };
  List<String> bank = ['ABA', 'ACLEDA', 'WOORY'];
  @override
  void onInit() {
    searchController.text = 'Walk-in Customer';
    discountCtr.text = '0';
    super.onInit();
  }

  void incrementQty() {
    qty++;
    update();
  }

  void decrementQty() {
    if (qty > 1) {
      qty--;
    }
    update();
  }

  void dizSelect(int index) {
    discountIndex = index;
    update();
  }

  void metSelect(int index) {
    methodIndex = index;
    update();
  }
}
