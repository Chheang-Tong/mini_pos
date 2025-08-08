import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/common/common.dart';
import '/feature/feature.dart';

class ProfileController extends GetxController {
  ProfileRepo profileRepo;
  ProfileController({required this.profileRepo});
  bool isLoading=true;
  bool isSubmitLoading=false;
  final TextEditingController firstNameCtr = TextEditingController(),
                               lastNameCtr = TextEditingController(),
                                  emailCtr = TextEditingController(),
                                  phoneCtr = TextEditingController();
  ProfileModel profileModel =ProfileModel();
  final Map<String, String> langItems = {
    'English': 'assets/images/usa_flag.jpg',
    'Khmer': 'assets/images/cambodia_flag.jpg',
  };

  int selectedLangIndex = 0;
  onLang(int index) {
    selectedLangIndex = index;
    update();
  }

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadProfile();
    isLoading = false;
    update();
  }

  Future<void> loadProfile({bool loadMore = false}) async {
    ResponseModel responseModel =await profileRepo.getProfile();
    if(responseModel.status){
      profileModel=ProfileModel.fromJson(jsonDecode(responseModel.responseJson));
    }else{
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    isLoading=false;
    update();
  }

  Future<void> loadProfileUpdateData()async{
    ResponseModel responseModel = await profileRepo.getProfile();
    if(responseModel.status){
      profileModel=ProfileModel.fromJson(jsonDecode(responseModel.responseJson));
      firstNameCtr.text=profileModel.data?.firstname??'';
      lastNameCtr.text=profileModel.data?.lastname??'';
      emailCtr.text=profileModel.data?.email??'';
      phoneCtr.text=profileModel.data?.phone??'';
    }else{
      CustomSnackBar.error(errorList: [responseModel.message.tr]);
    }
    isLoading=false;
    update();
  }

  Future<void>submitUpdate()async{

  }
}
