
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../core/core.dart';

addToCardDialog() {
  return Get.showSnackbar(
    GetSnackBar(
      messageText: Row(
        children: [
          // Icon(Icons.check_circle, color: Colors.white, size: 40,),
          Lottie.asset('assets/animations/success_animation.json',height: 40,width: 40,repeat: false),
          SizedBox(width: 8),
          Text(
            "Add to Cart Successful",
            style: semiBoldDefault.copyWith(
              color: ColorResources.successColor,
            ),
          ),
        ],
      ),
      maxWidth: 200,
      backgroundColor: ColorResources.dark25,
      borderRadius: 30,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      isDismissible: true,
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
    ),
  );
}