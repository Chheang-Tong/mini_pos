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
    ResponseModel responseModel =await apiService.request(url,Method.postMethod,map, passHeader: false);
    return responseModel;
  }
}