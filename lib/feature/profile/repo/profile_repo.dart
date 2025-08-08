
import '../../../common/common.dart';
import '../../../core/core.dart';

class ProfileRepo{
  ApiService apiService;
  ProfileRepo({required this.apiService});
  Future<ResponseModel>getProfile()async{
    final url =Uri.parse('${UrlContainer.baseUrl}${UrlContainer.profileUrl}');
    ResponseModel responseModel =await apiService.request(url.toString(), Method.getMethod, null,cartUuid: null,passHeader: true);
    return responseModel;
  }
}