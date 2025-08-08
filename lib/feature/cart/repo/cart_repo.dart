import '/common/common.dart';
import '/core/core.dart';

class CartRepo{
  ApiService apiService;
  CartRepo({required this.apiService});


  Future<ResponseModel>getCart({required String uuid})async{
    final url =Uri.parse('${UrlContainer.baseUrl}${UrlContainer.cartUrl}');
    ResponseModel responseModel =await apiService.request(url.toString(), Method.getMethod, null,cartUuid: uuid,passHeader: true);
    return responseModel;
  }

  Future<ResponseModel>addToCart({required String uuid,required int productId,required int qty, List<Map<String,dynamic>>?option})async{
    final url =Uri.parse('${UrlContainer.baseUrl}${UrlContainer.cartUrl}/add');
    Map<String,dynamic>map={
      "options":option??[],
      "product_id": productId,
      "quantity": qty
    };
    ResponseModel responseModel =await apiService.request(url.toString(), Method.postMethod,map,cartUuid: uuid,passHeader: true);
    return responseModel;
  }

  Future<ResponseModel>updateQty({required String uuid,required int cartId,required int qty,})async{
    final url =Uri.parse('${UrlContainer.baseUrl}${UrlContainer.cartUrl}/qty-adjustment');
    Map<String,dynamic>map={
      "cart_detail_id":cartId.toString(),
      "quantity":qty.toString()
    };
    ResponseModel responseModel =await apiService.request(url.toString(), Method.postMethod,map,cartUuid: uuid,passHeader: true);
    return responseModel;
  }

  Future<ResponseModel>rmProduct({required String uuid,required int cartId,required int qty,})async{
    final url =Uri.parse('${UrlContainer.baseUrl}${UrlContainer.cartUrl}/remove');
    Map<String,dynamic>map={
      "cart_detail_id": cartId,
    };
    ResponseModel responseModel =await apiService.request(url.toString(), Method.postMethod,map,cartUuid: uuid,passHeader: true);
    return responseModel;
  }

  Future<ResponseModel>rmProductAll({required String uuid})async{
    final url =Uri.parse('${UrlContainer.baseUrl}${UrlContainer.cartUrl}/empty');
    ResponseModel responseModel =await apiService.request(url.toString(), Method.postMethod,null,cartUuid: uuid,passHeader: true);
    return responseModel;
  }

  Future<ResponseModel>getUuid()async{
    final url =Uri.parse('${UrlContainer.baseUrl}${UrlContainer.cartUrl}/get-uuid');
    ResponseModel responseModel =await apiService.request(url.toString(), Method.getMethod, null,passHeader: true);
    return responseModel;
  }

  Future<ResponseModel>addDiscountInvoice({required String uuid,required String discount, required bool isFix})async{
    final url =Uri.parse('${UrlContainer.baseUrl}${UrlContainer.cartUrl}/add-discount-cart');
    Map<String,dynamic>map={
      "discount": discount,
      "is_discount_fixed": isFix
    };
    ResponseModel responseModel =await apiService.request(url.toString(), Method.postMethod,map,cartUuid: uuid,passHeader: true);
    return responseModel;
  }

  Future<ResponseModel>addDiscountItem({required String uuid,required String cartId,required String discount, required bool isFix})async{
    final url =Uri.parse('${UrlContainer.baseUrl}${UrlContainer.cartUrl}/add-discount-cart-detail');
    Map<String,dynamic>map={
      "cart_detail_id": cartId,
      "discount": discount,
      "is_discount_fixed": isFix
    };
    ResponseModel responseModel =await apiService.request(url.toString(), Method.postMethod,map,cartUuid: uuid,passHeader: true);
    return responseModel;
  }
}