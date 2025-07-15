import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/core.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key, required this.onPressed});
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.space20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/empty.svg'),
          Text('Your cart is currently empty!.', style: semiBoldMediumLarge),
          Text(
            'You may check out all the available products and buy some in the shop.',
            style: regularLarge.copyWith(letterSpacing: 0.02),
            textAlign: TextAlign.center,
          ),
          Container(
            height: size.height * 0.048,
            margin: EdgeInsets.symmetric(
              vertical: Dimensions.space20,
              horizontal: Dimensions.space60,
            ),
            child: ElevatedButton(
              onPressed: () => onPressed(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorResources.primaryColor,
                minimumSize: Size(size.width, Dimensions.defaultButtonH),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.largeRadius),
                ),
              ),
              child: Text(
                'Start Selling',
                style: semiBoldMediumLarge.copyWith(
                  color: ColorResources.whiteColor,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.15),
        ],
      ),
    );
  }
}
