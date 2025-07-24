import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '/core/core.dart';
import '/common/common.dart';

class ApiService extends GetxService{
  Future<ResponseModel> request(String uri, String method, Map<String, dynamic>? params,
      {bool passHeader = false})async{
    Uri url=Uri.parse(uri);
    http.Response response;
    String token='';

    try {
      if(method==Method.postMethod){
        if(passHeader){
          response=await http.post(url,body: params,headers: {
            'Accept':'application/json',
            'Authorization':token
          });
        }else{
          response =await http.post(url,body: params);
        }
      }else if(method==Method.putMethod){
        response = await http.put(url,body: params,headers: {
          'Content-Type':'application/x-www-form-urlencode; charset=UTF-8',
          'Accept':'application/json',
          'Authorization':token,
        });
      }else if(method==Method.deleteMethod){
        response=await http.delete(url,headers: {
          'Accept':'application/json',
          'Authorization':token,
        });
      }else{
        if(passHeader){
          response =await http.get(url,headers: {
            'Accept':'application/json',
            'Authorization':token,
          });
        }else{
          response =await http.get(url);
        }
      }
      if (kDebugMode) {
        print('====> url: ${uri.toString()}');
        print('====> method: $method');
        print('====> params: ${params.toString()}');
        print('====> status: ${response.statusCode}');
        print('====> body: ${response.body.toString()}');
        print('====> token: $token');
      }
      StatusModel model =StatusModel.fromJson(jsonDecode(response.body));

      if(response.statusCode==200){
        try{
          if(!model.status!){
            Get.offAllNamed(RouteHelper.welcomeScreen);
          }
        }catch (e){
          e.toString();
        }
        return ResponseModel(true, model.message!.tr, response.body);
      } else if (response.statusCode == 401) {
        Get.offAllNamed(RouteHelper.authScreen);
        return ResponseModel(false, model.message!.tr, response.body);
      } else if (response.statusCode == 404) {
        return ResponseModel(false, model.message!.tr, response.body);
      } else if (response.statusCode == 500) {
        return ResponseModel(
            false, model.message?.tr ?? 'LocalStrings.serverError.tr', '');
      } else {
        return ResponseModel(
            false, model.message?.tr ?? 'LocalStrings.somethingWentWrong.tr', '');
      }

    }on SocketException{
      return ResponseModel(false, 'Something went wrong...', '');
    }on FormatException{
      Get.offAllNamed(RouteHelper.authScreen);

      return ResponseModel(false, 'Bad Response', '');
    }catch (e){
      return ResponseModel(false,e.toString(),'');
    }
  }
}
