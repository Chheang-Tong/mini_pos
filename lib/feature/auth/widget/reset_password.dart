import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minipos_app/feature/auth/auth.dart';
import 'package:minipos_app/feature/auth/controller/controller.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(AuthRepo(apiService: Get.find()));
    Get.put(AuthController(authRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        appBar: CustomAppBar(
          lead: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)
          ),
          title: Text('Reset Password'),
          action: GestureDetector(
            onTap: ()async{
              if (controller.formKey.currentState!.validate()) {
                await controller.changePw();
              }

            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.defaultPadding,
                horizontal: Dimensions.space12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                color: ColorResources.primary5,
              ),
              child: Text(
                'Update',
                style: mediumLarge.copyWith(
                  color: ColorResources.primaryColor,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(Dimensions.largeMargin),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.largePadding,
                    bottom: Dimensions.defaultPadding,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Old password',
                        style: semiBoldMediumLarge,
                      ),
                      Text(
                        ' *',
                        style: semiBoldMediumLarge.copyWith(
                          color: ColorResources.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  controller: controller.oldPasswordCtr,
                  focusNode: controller.oldPasswordFN,
                  nextFocus: controller.newPasswordFN,
                  onChanged: (onChanged) {
                    if (controller.oldPasswordError != null) {
                      controller.oldPasswordError = null;
                      controller.formKey.currentState!.validate();
                    }
                  },
                  noneBorder: true,
                  fillColor: ColorResources.dark5,
                  hintText: 'Enter Old Password',
                  validator: (value) {
                    return controller.oldPasswordError;
                  },
                ),
                Text(
                  'Password must be at least 8 character',
                  style: regularMediumLarge.copyWith(
                    color: ColorResources.dark75,
                    // height: 16,
                    letterSpacing: 0.02,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.largePadding,
                    bottom: Dimensions.defaultPadding,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'New password',
                        style: semiBoldMediumLarge,
                      ),
                      Text(
                        ' *',
                        style: semiBoldMediumLarge.copyWith(
                          color: ColorResources.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  controller: controller.newPasswordCtr,
                  focusNode: controller.newPasswordFN,
                  nextFocus: controller.confirmPasswordFN,
                  onChanged: (onChanged) {},
                  noneBorder: true,
                  fillColor: ColorResources.dark5,
                  hintText: 'Enter New Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please re-enter your password";
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    return null; // valid

                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.largePadding,
                    bottom: Dimensions.defaultPadding,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Confirm New password',
                        style: semiBoldMediumLarge,
                      ),
                      Text(
                        ' *',
                        style: semiBoldMediumLarge.copyWith(
                          color: ColorResources.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  controller: controller.confirmPasswordCtr,
                  focusNode: controller.confirmPasswordFN,
                  onChanged: (onChanged) {},
                  noneBorder: true,
                  fillColor: ColorResources.dark5,
                  hintText: 'Re-enter Password',
                  inputAction: TextInputAction.done,
                  validator: (value) {
                        if (value == null || value.isEmpty) {
                        return "Please re-enter your password";
                        }
                        if (value.length < 8) {
                        return "Password must be at least 8 characters";
                        }
                        if (value != controller.newPasswordCtr.text) {
                          return "The password confirmation does not match.";
                        }
                        return null;

                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}