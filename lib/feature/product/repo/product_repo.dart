import '/common/common.dart';
import '/core/core.dart';

class ProductRepo{
  ApiService apiService;
  ProductRepo({required this.apiService});
  Future<ResponseModel>getProduct({int limit = 10, int page = 1,String start='',String end ='',String promoId='',String sort=''})async{
    Map<String,String>map={
      'limit':limit.toString(),
      'page':page.toString(),
      'start_price':start,
      'end_price':end,
      'promotion_id':promoId,
      'sort_by':sort,
    };
    final url =Uri.parse('${UrlContainer.baseUrl}${UrlContainer.productUrl}').replace(queryParameters:map);
    ResponseModel responseModel =await apiService.request(url.toString(), Method.getMethod, null,cartUuid: null,passHeader: true);
    return responseModel;
  }
}