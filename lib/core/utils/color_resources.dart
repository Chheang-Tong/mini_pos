import 'package:flutter/material.dart';

class ColorResources {
  static const Color primaryColor = Color(0xffDE2348);
  static const Color secondColor = Color(0xff363233);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color bgColor = Color(0xffF0F0F0);
  static const Color shadowColor = Color(0xff3A090B);
  static const Color darkColor = Color(0xFF231F20);
  static const Color errorColor = Color(0xffB13439);
  static const Color successColor = Color(0xFF34B164);
  static const Color pendingColor = Color(0xffDE9307);
  static const Color shippingColor = Color(0xff1F6BCF);
  static const Color transparentColor = Colors.transparent;

  static Color primary75 = primaryColor.withOpacity(0.75);
  static Color primary45 = primaryColor.withOpacity(0.45);
  static Color primary25 = primaryColor.withOpacity(0.25);
  static Color primary10 = primaryColor.withOpacity(0.10);
  static Color primary5 = primaryColor.withOpacity(0.05);

  static Color second75 = secondColor.withOpacity(0.75);
  static Color second45 = secondColor.withOpacity(0.45);
  static Color second25 = secondColor.withOpacity(0.25);
  static Color second10 = secondColor.withOpacity(0.10);
  static Color second5 = secondColor.withOpacity(0.05);

  static Color white75 = whiteColor.withOpacity(0.75);
  static Color white45 = whiteColor.withOpacity(0.45);
  static Color white25 = whiteColor.withOpacity(0.25);
  static Color white10 = whiteColor.withOpacity(0.10);
  static Color white5 = whiteColor.withOpacity(0.05);

  static Color dark75 = darkColor.withOpacity(0.75);
  static Color dark45 = darkColor.withOpacity(0.45);
  static Color dark25 = darkColor.withOpacity(0.25);
  static Color dark10 = darkColor.withOpacity(0.10);
  static Color dark5 = darkColor.withOpacity(0.05);

  static Color success75 = successColor.withOpacity(0.75);
  static Color success45 = successColor.withOpacity(0.45);
  static Color success25 = successColor.withOpacity(0.25);
  static Color success10 = successColor.withOpacity(0.10);
  static Color success5 = successColor.withOpacity(0.05);

  static Color getPrimaryColor() {
    return primaryColor;
  }

  static Color orderStatusColor(String state) {
    Color color = ColorResources.primaryColor;
    switch (state) {
      case '1': // Pending
        color = ColorResources.pendingColor;
        break;
      case '2': // Shipping
        color = ColorResources.shippingColor;
        break;
      case '3': // Completed
        color = ColorResources.successColor;
        break;
      case '4': // Cancelled
        color = ColorResources.errorColor;
        break;
    }
    return color;
  }

  static Color notificationStatusColor(String state) {
    Color color = ColorResources.primaryColor;
    switch (state) {
      case '1': // Place
        color = Color(0xFF8F9F5A);
        break;
      case '2': //pending
        color = Color(0xFFE2BE30);
        break;
      case '3': // Shipping
        color = Color(0xFFDA6822);
        break;
      case '4': // Completed
        color = ColorResources.successColor;
        break;
      case '5': // Cancelled
        color = ColorResources.errorColor;
        break;
    }
    return color;
  }

  static Color getdark45() {
    return dark45;
  }

  static Color getPrimaryButtonColor() {
    return primaryColor;
  }

  static Color getCardBgColor() {
    return dark45;
  }

  static Color getTextColor() {
    return dark75;
  }

  // transparent color
  static Color getTransparentColor() {
    return transparentColor;
  }
}
