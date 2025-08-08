import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/core.dart';
import '/common/common.dart';

class ApiService extends GetxService{
  SharedPreferences sharedPreferences;
  ApiService({required this.sharedPreferences});

  Future<ResponseModel> request(String uri, String method, Map<String, dynamic>? params,
      {String? cartUuid, bool passHeader = false})async{
    Uri url=Uri.parse(uri);
    http.Response response;

    try {
      if(method==Method.postMethod){
        if(passHeader){
          initToken();

          final body = params != null ? jsonEncode(params) : null;
          response=await http.post(url,body: body,headers: {
            if(cartUuid!=null)
              'cart-uuid':cartUuid,
            'Content-Type':'application/json',
            'Accept':'application/json',
            'Authorization':'Bearer $token',
          });
        }else{
          response =await http.post(url,body: params);
        }
      }else if(method==Method.putMethod){
        initToken();

        final body = params != null ? jsonEncode(params) : null;
        response = await http.put(url,body: body,headers: {
          'Content-Type':'application/json',
          if(cartUuid!=null)
            'cart-uuid':cartUuid,
          'Accept':'application/json',
          'Authorization':'Bearer $token',
        });
      }else if(method==Method.deleteMethod){
        initToken();

        response=await http.delete(url,headers: {
          // 'Content-Type': 'application/json',
          if(cartUuid!=null)
            'cart-uuid':cartUuid,
          'Accept':'application/json',
          'Authorization':'Bearer $token',
        });
      }else{
        if(passHeader){
          initToken();
          response =await http.get(
              url,
              headers: {
            'Accept':'application/json',
            'Content-Type': 'application/json',

             if(cartUuid!=null)
                'cart-uuid':cartUuid,
            'Authorization':'Bearer $token',
          });
        }else{
          initToken();
          response =await http.get(url);

          debugPrint('dart:$token');
        }
      }
      if (kDebugMode) {
        print('====> Uuid: $cartUuid');
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
            sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
            sharedPreferences.remove(SharedPreferenceHelper.token);
            Get.offAllNamed(RouteHelper.welcomeScreen);
          }
        }catch (e){
          e.toString();
        }
        return ResponseModel(true, model.message!.tr, response.body);
      } else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        Get.offAllNamed(RouteHelper.authScreen);
        return ResponseModel(false, model.message!.tr, response.body);
      } else if (response.statusCode == 404) {
        return ResponseModel(false, model.message!.tr, response.body);
      } else if (response.statusCode == 500) {
          // print('token in 500:$token');
        // sharedPreferences.remove(SharedPreferenceHelper.token);
        //   print('token clear:$token');
        return ResponseModel(
            false, model.message?.tr ?? 'LocalStrings.serverError.tr', '');
      } else {
        return ResponseModel(
            false, model.message?.tr ?? 'LocalStrings.somethingWentWrong.tr', '');
      }

    }on SocketException{
      return ResponseModel(false, 'Something went wrong...', '');
    }on FormatException{
      sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
      Get.offAllNamed(RouteHelper.authScreen);

      return ResponseModel(false, 'Bad Response', '');
    }catch (e){
      return ResponseModel(false,e.toString(),'');
    }
  }
  String token='';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t =
      sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      token = t ?? '';
    } else {
      token = '';
    }
  }
}
