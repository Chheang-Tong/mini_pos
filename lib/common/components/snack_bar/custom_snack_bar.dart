
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';


class CustomSnackBar {
  static error({required List<String> errorList, int duration = 2}) {
    String message = '';
    if (errorList.isEmpty) {
      message = "somethingWentWrong".tr;
    } else {
      for (var element in errorList) {
        String tempMessage = element;
        message = message.isEmpty ? tempMessage : "$message\n$tempMessage";
      }
    }
    message = Converter.removeQuotationAndSpecialCharacterFromString(message);
    Get.rawSnackbar(
      progressIndicatorBackgroundColor: ColorResources.transparentColor,
      progressIndicatorValueColor:
      const AlwaysStoppedAnimation<Color>(Colors.transparent),
      messageText: Text(message,
          style: regularLarge.copyWith(color: ColorResources.whiteColor)),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorResources.primaryColor,
      borderRadius: 4,
      margin: const EdgeInsets.all(Dimensions.space8),
      padding: const EdgeInsets.all(Dimensions.space8),
      duration: Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeIn,
      showProgressIndicator: true,
      leftBarIndicatorColor: ColorResources.transparentColor,
      animationDuration: const Duration(seconds: 1),
      borderColor: ColorResources.transparentColor,
      reverseAnimationCurve: Curves.easeOut,
      borderWidth: 2,
    );
  }

  static success({required List<String> successList, int duration = 5}) {
    String message = '';
    if (successList.isEmpty) {
      message = "somethingWentWrong".tr;
    } else {
      for (var element in successList) {
        String tempMessage = element;
        message = message.isEmpty ? tempMessage : "$message\n$tempMessage";
      }
    }
    message = Converter.removeQuotationAndSpecialCharacterFromString(message);
    Get.rawSnackbar(
      progressIndicatorBackgroundColor: ColorResources.successColor,
      progressIndicatorValueColor:
      const AlwaysStoppedAnimation<Color>(ColorResources.transparentColor),
      messageText: Text(message,
          style: regularLarge.copyWith(color: ColorResources.whiteColor)),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorResources.successColor,
      borderRadius: 4,
      margin: const EdgeInsets.all(Dimensions.space8),
      padding: const EdgeInsets.all(Dimensions.space8),
      duration: Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
      showProgressIndicator: true,
      leftBarIndicatorColor: ColorResources.transparentColor,
      animationDuration: const Duration(seconds: 2),
      borderColor: ColorResources.transparentColor,
      reverseAnimationCurve: Curves.easeOut,
      borderWidth: 2,
    );
  }
}