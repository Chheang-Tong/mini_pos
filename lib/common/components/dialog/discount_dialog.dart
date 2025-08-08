import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

discountDialog({required Widget content, required Function onTap}) {
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
      title: Text('Discount'),
      titleTextStyle: semiBoldMediumLarge.copyWith(
        color: ColorResources.darkColor,
      ),
      content: content,
      actions: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    // horizontal: Dimensions.space48,
                    vertical: Dimensions.space10,
                  ),
                  margin: EdgeInsets.only(right: Dimensions.defaultMargin),
                  decoration: BoxDecoration(
                    color: ColorResources.dark5,
                    borderRadius: BorderRadius.circular(
                      Dimensions.defaultRadius,
                    ),
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
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => onTap(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    // horizontal: Dimensions.space48,
                    vertical: Dimensions.space10,
                  ),
                  margin: EdgeInsets.only(left: Dimensions.defaultMargin),
                  decoration: BoxDecoration(
                    color: ColorResources.primaryColor,
                    borderRadius: BorderRadius.circular(
                      Dimensions.defaultRadius,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'OK',
                      style: semiBoldMediumLarge.copyWith(
                        color: ColorResources.whiteColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
