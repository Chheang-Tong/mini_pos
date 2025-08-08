import '../../../common/common.dart';
import '../../../core/core.dart';

class WelRepo{
  ApiService apiService;
  WelRepo({required this.apiService});
  Future<ResponseModel>fetchWelData()async{
    Map<String,String>map={
      'start_date':'',
      'end_date':''
    };
    String url='${UrlContainer.baseUrl}${UrlContainer.dashboardUrl}';
    ResponseModel responseModel =await apiService.request(url,'get',map,cartUuid:null, passHeader:true);
    return responseModel;
  }
}