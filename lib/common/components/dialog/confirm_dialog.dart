import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

confirmClear({required Function onTap}) {
  return Get.dialog(
    AlertDialog(
      backgroundColor: ColorResources.whiteColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      actionsPadding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      title: Center(child: Text('Confirm Clear')),
      titleTextStyle: boldOverLarge.copyWith(color: ColorResources.darkColor),
      content: Text(
        'Your items will be removed, Are you sure want to clear from your cart?',
        style: regularDefault.copyWith(),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.space48,
                  vertical: Dimensions.space10,
                ),
                margin: EdgeInsets.only(right: Dimensions.defaultMargin),
                decoration: BoxDecoration(
                  color: ColorResources.dark5,
                  borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: semiBoldMediumLarge.copyWith(
                      color: ColorResources.dark75,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onTap(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.space48,
                  vertical: Dimensions.space10,
                ),
                margin: EdgeInsets.only(left: Dimensions.defaultMargin),
                decoration: BoxDecoration(
                  color: ColorResources.primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                ),
                child: Center(
                  child: Text(
                    'Yes',
                    style: semiBoldMediumLarge.copyWith(
                      color: ColorResources.whiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
