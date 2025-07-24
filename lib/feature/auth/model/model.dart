
class LoginModel {

  LoginModel({
   String? accessToken,
  }){
    _accessToken=accessToken;
  }

 LoginModel.fromJson(dynamic json){
    _accessToken=json['access_token'];
 }
 String ? _accessToken;
  String? get accessToken=> _accessToken;

  Map<String, dynamic> toJson(){
    final map = <String,dynamic>{};
    map['access_token']=_accessToken;
    return map;
  }
}