import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minipos_app/feature/auth/controller/controller.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';
import '../../feature.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiService());
    Get.put(AuthRepo(apiService: Get.find()));
    Get.put(AuthController(authRepo: Get.find()));
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // Get.find<AuthController>().remember = false;
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.bgColor,
      body: GetBuilder<AuthController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              AuthView(title: 'Log In'),
              Form(
                key: formKey,
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
                        controller: controller.emailCtr,
                        focusNode: controller.emailFN,
                        nextFocus: controller.passwordFN,
                        onChanged: (onChanged) {},
                        hintText: 'example@.com',
                        fillColor: ColorResources.dark5,
                        noneBorder: true,
                        textInputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'It null';
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: Dimensions.space24),
                      CustomTextField(
                        controller: controller.passwordCtr,
                        focusNode: controller.passwordFN,
                        onChanged: (onChanged) {},
                        hintText: 'Password',
                        fillColor: ColorResources.dark5,
                        noneBorder: true,
                        isPassword: true,
                        isShowSuffixIcon: true,
                        isIcon: true,
                        textInputType: TextInputType.visiblePassword,
                        inputAction: TextInputAction.done,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'It null';
                          }
                          else{
                            return null;
                          }
                        },
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
                         if(formKey.currentState!.validate()){
                           controller.login();
                         }
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
        );
      }),
    );
  }
}
