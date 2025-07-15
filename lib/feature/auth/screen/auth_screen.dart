import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/commen.dart';
import '../../../core/core.dart';
import '../../feature.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthView(title: 'Log In'),
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.largePadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email', style: semiBoldMediumLarge),
                    SizedBox(height: Dimensions.space8),
                    CustomTextField(
                      onChanged: (onChanged) {},
                      hintText: 'example@.com',
                      fillColor: ColorResources.dark5,
                      noneBorder: true,
                      textInputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    SizedBox(height: Dimensions.space24),
                    CustomTextField(
                      onChanged: (onChanged) {},
                      hintText: 'Password',
                      fillColor: ColorResources.dark5,
                      noneBorder: true,
                      isPassword: true,
                      isShowSuffixIcon: true,
                      isIcon: true,
                      textInputType: TextInputType.visiblePassword,
                      inputAction: TextInputAction.done,
                    ),
                    SizedBox(height: Dimensions.space24),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorResources.primaryColor,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(RouteHelper.welcomeScreen);
                      },
                      child: Text(
                        'Login',
                        style: semiBoldMediumLarge.copyWith(
                          color: ColorResources.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
