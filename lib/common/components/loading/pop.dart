
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

class WillPopWidget extends StatelessWidget {
  final Widget child;
  final String nextRoute;

  const WillPopWidget({super.key, required this.child, this.nextRoute = ''});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (nextRoute.isEmpty) {
            showExitDialog(context);
            return Future.value(false);
          } else {
            Get.offAndToNamed(nextRoute);
            return Future.value(false);
          }
        },
        child: child);
  }
}
showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: ColorResources.getCardBgColor(),
      insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.space40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: Dimensions.space40,
                  bottom: Dimensions.space15,
                  left: Dimensions.space15,
                  right: Dimensions.space15),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: ColorResources.getCardBgColor(),
                  borderRadius:
                  BorderRadius.circular(Dimensions.defaultRadius)),
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.space10),
                  Text(
                    'LocalStrings.exit.tr',
                    style: regularSmall.copyWith(
                        color: ColorResources.getTextColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.fontDefault + 3),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                  Text(
                    'LocalStrings.exitTitle.tr',
                    style: regularSmall.copyWith(
                        color: ColorResources.getTextColor(),
                        fontSize: Dimensions.fontDefault),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                  const SizedBox(height: Dimensions.space20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RoundedButton(
                          text: 'No',
                          press: () {
                            Navigator.pop(context);
                          },
                          horizontalPadding: 3,
                          verticalPadding: 3,
                          color: ColorResources.dark45,
                          textColor: ColorResources.whiteColor,
                        ),
                      ),
                      const SizedBox(width: Dimensions.space10),
                      Expanded(
                        child: RoundedButton(
                            text: 'Yes',
                            press: () {
                              SystemNavigator.pop();
                            },
                            horizontalPadding: 3,
                            verticalPadding: 3,
                            color: ColorResources.getPrimaryColor(),
                            textColor: ColorResources.whiteColor),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: -40,
              left: MediaQuery.of(context).padding.left,
              right: MediaQuery.of(context).padding.right,
              child: Image.asset(
                MyImages.warningImage,
                height: 80,
                width: 80,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class RoundedButton extends StatelessWidget {
  final bool isColorChange;
  final String text;
  final VoidCallback press;
  final Color color;
  final Color? textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  final bool isOutlined;
  final Widget? child;

  const RoundedButton({
    super.key,
    this.isColorChange = false,
    this.width = 1,
    this.child,
    this.cornerRadius = 6,
    required this.text,
    required this.press,
    this.isOutlined = false,
    this.horizontalPadding = 35,
    this.verticalPadding = 18,
    this.color = ColorResources.primaryColor,
    this.textColor = ColorResources.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return child != null
        ? InkWell(
      onTap: press,
      splashColor: ColorResources.bgColor,
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          width: size.width * width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cornerRadius),
              color: isColorChange
                  ? color
                  : ColorResources.getPrimaryButtonColor()),
          child: Center(
              child: Text(text.tr,
                  style: regularDefault.copyWith(
                      color: isColorChange
                          ? textColor
                          : ColorResources
                          .primaryColor)))),
    )
        : isOutlined
        ? Material(
      child: InkWell(
        onTap: press,
        splashColor: ColorResources.bgColor,
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding),
            width: size.width * width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius),
                color: isColorChange
                    ? color
                    : ColorResources.getPrimaryButtonColor()),
            child: Center(
                child: Text(text.tr,
                    style: regularDefault.copyWith(
                        color: isColorChange
                            ? textColor
                            : ColorResources.primaryColor
                            )))),
      ),
    )
        : SizedBox(
      width: size.width * width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1.0),
        child: ElevatedButton(
          onPressed: press,
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shadowColor: ColorResources.transparentColor,
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding),
              textStyle: regularDefault.copyWith(color: textColor)),
          child: Text(
            text.tr,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}