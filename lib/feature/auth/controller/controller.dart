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
  String? oldPasswordError;
  final formKey = GlobalKey<FormState>();


  final  TextEditingController
    emailCtr = TextEditingController(text: 'mama@gmail.com'),
    passwordCtr = TextEditingController(text: 'Manin@1234'),
    newPasswordCtr=TextEditingController(),
    oldPasswordCtr=TextEditingController(),
    confirmPasswordCtr=TextEditingController();

  final FocusNode emailFN = FocusNode(), passwordFN = FocusNode(),oldPasswordFN=FocusNode(),newPasswordFN=FocusNode(),confirmPasswordFN=FocusNode();

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

  Future<void>changePw()async{
    isSubmitLoading=true;
    update();
    ResponseModel responseModel= await authRepo.updatePassword(oldPassword: oldPasswordCtr.text, newPassword: newPasswordCtr.text, passwordConfirm: confirmPasswordCtr.text);
    if(responseModel.status){
      oldPasswordError=null;
      CustomSnackBar.success(successList: [responseModel.message]);
    }
    else{
      oldPasswordError=responseModel.message;
      CustomSnackBar.error(errorList: [oldPasswordError!]);
      formKey.currentState!.validate();

    }

    isSubmitLoading=false;
    update();
  }

}
