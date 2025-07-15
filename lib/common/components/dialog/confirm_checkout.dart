import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

confirmCheckout({required Widget content, required List<Widget> action}) {
  return Get.dialog(
    AlertDialog(
      backgroundColor: ColorResources.whiteColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.largeRadius),
      ),
      titlePadding: EdgeInsets.symmetric(
        horizontal: Dimensions.space16,
        vertical: Dimensions.space16,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.space16),
      actionsPadding: EdgeInsets.symmetric(
        vertical: Dimensions.space16,
        horizontal: Dimensions.space16,
      ),
      title: Text('Confirming'),
      titleTextStyle: semiBoldMediumLarge.copyWith(
        color: ColorResources.darkColor,
      ),
      content: content,
      actions: action,
    ),
  );
}
