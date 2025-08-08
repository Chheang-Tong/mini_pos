import '/common/common.dart';
import '/core/core.dart';

class AuthRepo{
  ApiService apiService;
  AuthRepo({required this.apiService});

  Future<ResponseModel>logIn(String email,String password)async{
    Map<String,String>map={
      'email':email,
      'password':password
    };
    String url='${UrlContainer.baseUrl}${UrlContainer.loginUrl}';
    ResponseModel responseModel =await apiService.request(url,Method.postMethod,map, cartUuid: null,passHeader: false);
    return responseModel;
  }

  Future<ResponseModel>updatePassword({required String oldPassword,required String newPassword,required String passwordConfirm})async{
    Map<String,String>map={
      'old_password':oldPassword,
      'password':newPassword,
      'password_confirmation':passwordConfirm,
    };
    String url='${UrlContainer.baseUrl}${UrlContainer.updatePasswordUrl}';
    ResponseModel responseModel =await apiService.request(url,Method.postMethod,map, cartUuid: null,passHeader: true);
    return responseModel;
  }
}