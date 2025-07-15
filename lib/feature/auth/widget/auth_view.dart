import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

import '../../../core/core.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key, required this.title, this.imageUrl});
  final String title;
  final String? imageUrl;

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFDE2348), Color(0xFF80221F)],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -37,
            left: -107,
            child: Container(
              width: size.width * 0.95,
              height: size.width * 0.95,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorResources.white10,
              ),
            ),
          ),
          Positioned(
            top: -152,
            left: -222,
            child: Container(
              width: size.width * 1.5,
              height: size.width * 1.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorResources.white5,
              ),
            ),
          ),

          Positioned(
            left: 20,
            top: 83,
            right: 20,
            child: Center(
              child: SvgPicture.asset('assets/images/white_logo.svg'),
            ),
          ),
          Positioned(
            bottom: -5,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.1,
              decoration: BoxDecoration(
                color: ColorResources.bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.largePadding,
                      // vertical: Dimensions.space23,
                    ),
                    child: Text(
                      widget.title,
                      style: boldMegaLarge.copyWith(
                        color: ColorResources.darkColor,
                        fontSize: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
