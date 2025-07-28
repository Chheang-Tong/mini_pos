import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/core.dart';

customBottomSheet({
  bool isScrollControlled = true,
  bool persistent = false,
  bool drag = true,
  double horizontal = Dimensions.defaultPadding,
  double vertical = Dimensions.largePadding,
  required BuildContext context,
  required double height,
  required double width,
  required Widget body,
}) {
  Get.bottomSheet(
    isScrollControlled: isScrollControlled,
    persistent: persistent,
    enableDrag: drag,
    AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 50),
      curve: Curves.decelerate,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        constraints: BoxConstraints(maxHeight: height),
        width: width,
        decoration: BoxDecoration(
          color: ColorResources.bgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.largeRadius),
            topRight: Radius.circular(Dimensions.largeRadius),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 6,
                width: 32,
                decoration: BoxDecoration(
                  color: ColorResources.dark45.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: Dimensions.space16),
            Expanded(child: body),
          ],
        ),
      ),
    ),
  );
}
