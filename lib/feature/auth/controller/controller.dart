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
    }
    else{
print(responseModel.status);
    }

    isSubmitLoading=false;
    update();
  }
  void clearTextField() {
    passwordCtr.text = '';
    emailCtr.text = '';
    update();
  }
}
