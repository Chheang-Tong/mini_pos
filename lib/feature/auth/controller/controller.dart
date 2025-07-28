import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/common/common.dart';
import '/core/core.dart';
import '../../feature.dart';

class AuthController extends GetxController {
  AuthRepo authRepo;
  AuthController({required this.authRepo});


  String? email;
  String? password;
  bool isSubmitLoading=false;
  bool remember=false;
  TextEditingController emailCtr = TextEditingController(text: 'mama@gmail.com');
  TextEditingController passwordCtr = TextEditingController(text: 'Manin@123');
  final FocusNode emailFN = FocusNode();
  final FocusNode passwordFN = FocusNode();

  Future <void> login()async{
    isSubmitLoading=true;
    update();

    ResponseModel responseModel= await authRepo.logIn(
        emailCtr.text.toString(),
        passwordCtr.text.toString(),
    );
    if(responseModel.status){
      LoginModel loginModel =LoginModel.fromJson(
          jsonDecode(responseModel.responseJson),
      );

      Get.offAndToNamed(RouteHelper.welcomeScreen);
      check(loginModel);

    }
    else{
      CustomSnackBar.error(errorList: [responseModel.status.toString()]);
    }

    isSubmitLoading=false;
    update();
  }
  void clearTextField() {
    passwordCtr.text = '';
    emailCtr.text = '';
    if (remember) {
      remember = false;
    }
    update();
  }

  Future<void>check(LoginModel loginModel)async{
    if(remember){
      await authRepo.apiService.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    }else{
      await authRepo.apiService.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    }
    await authRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenKey,
        loginModel.accessToken ?? '');

    // Get.offAndToNamed(RouteHelper.authScreen);
    if(remember){
      changeRememberMe();
    }

  }
  changeRememberMe() {
    remember = !remember;
    update();
  }

}
