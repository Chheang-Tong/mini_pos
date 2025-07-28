import 'dart:convert';
import 'package:get/get.dart';
import '/common/common.dart';
import '/feature/feature.dart';

class WelcomeController extends GetxController{
  WelRepo welRepo;
  WelcomeController({required this.welRepo});
  bool isLoading=true;
  WelModel welModel= WelModel();

  Future<void> initialData({bool loading=true})async{
    isLoading= loading?true:false;
    update();
    await loadData();
    isLoading=false;
    update();
  }

  Future<dynamic>loadData()async{
    ResponseModel responseModel= await welRepo.fetchWelData();
    if(responseModel.status){
      welModel= WelModel.fromJson(jsonDecode(responseModel.responseJson));
    }
    else{
      welModel =WelModel();
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    isLoading=false;
    update();
  }
}