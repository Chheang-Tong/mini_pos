// import 'dart:convert';
//
// import 'package:get/get.dart';
// import '/common/common.dart';
// import '/feature/feature.dart';
//
// class ProductController extends GetxController{
//   ProductRepo productRepo;
//   ProductController({required this.productRepo});
//   ProductModel productModel=ProductModel();
//
//   final List<String> categories = [
//     'Fruits',
//     'Vegetables',
//     'Dairy',
//     'Bakery',
//     'Beverages',
//     'Snacks',
//   ];
//
//   bool isLoading = true;
//   bool isSubmitLoading = false;
//   var currentPage = 1;
//   var lastPage = 1;
//
//   Future<void> initialData({bool shouldLoad = true}) async {
//     isLoading = shouldLoad ? true : false;
//     update();
//
//     await loadProduct();
//     isLoading = false;
//     update();
//   }
//
//   Future<void>loadProduct()async{
//     ResponseModel responseModel= await productRepo.getProduct(limit: 10,page: currentPage);
//     if (responseModel.status) {
//       productModel =
//           ProductModel.fromJson(jsonDecode(responseModel.responseJson));
//     } else {
//       productModel = ProductModel();
//       CustomSnackBar.error(errorList: [responseModel.message]);
//     }
//     isLoading = false;
//     update();
//   }
//
// }

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/product_model.dart';
import '/common/common.dart';
import '/feature/feature.dart';

class ProductController extends GetxController {
  ProductRepo productRepo;
  ProductController({required this.productRepo});
  final ScrollController scrollController=ScrollController();
  TextEditingController fromController = TextEditingController(),
      toController = TextEditingController();
  FocusNode fromNode = FocusNode(), toNode = FocusNode();
  ProductModel productModel = ProductModel();
  List<Product> products = [];

  @override
  void onInit() {
    super.onInit();

    // Add listener for infinite scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 &&
          !isMoreLoading &&
          currentPage < lastPage) {
        loadProduct(loadMore: true);
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  final List<String> categories = [
    'Fruits',
    'Vegetables',
    'Dairy',
    'Bakery',
    'Beverages',
    'Snacks',
  ];
  List<String> items = ['Discount'];

  List<String> sorts = ['New', 'In Stock', 'Out of Stock'];

  bool isLoading = true;
  bool isSubmitLoading = false;
  var currentPage = 1;
  var lastPage = 1;
  bool isMoreLoading = false;


  String? selectedValue;
  int? selectSort ;
  sort(int index) {
   selectSort=index;
    update();
  }

  nullValue() {
    selectedValue = null;
    update();
  }

  bool get isFilterEmpty {
    return fromController.text.isEmpty &&
        toController.text.isEmpty &&
        selectedValue == null &&
        selectSort == null;
  }



  void reset() {
    fromController.text = '';
    toController.text = '';
    selectedValue = null;
    selectSort = null;
    update();
  }

  void onChanged(String newValue) {
    selectedValue = newValue;
    update();
  }

  /// Initial load
  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad;
    currentPage = 1;
    products.clear();
    update();
    await loadProduct();
    isLoading = false;
    update();
  }

  void filterProducts() async {
    currentPage = 1;
    lastPage=1;
    products.clear();
    scrollController.jumpTo(0);
    update();
    await loadProduct();
  }//not use yet

  Future<void> loadProduct({bool loadMore = false}) async {
    if (loadMore) {
      if (currentPage >= lastPage) return;
      isMoreLoading = true;
      update();
      await Future.delayed(const Duration(seconds:2));//highlight only need delete when use
      currentPage++;

    } else {
      currentPage = 1;
      lastPage=1;
      products.clear();
    }
    String startPrice = fromController.text.isNotEmpty ? fromController.text : '';
    String endPrice = toController.text.isNotEmpty ? toController.text : '';
    String promoId = selectedValue ?? '';
    String sortBy = selectSort != null ? sorts[selectSort!] : '';
    ResponseModel responseModel =await productRepo.getProduct(
        limit: 10,
        page: currentPage,
        start: startPrice,
        end: endPrice,
        promoId: promoId,
        sort: sortBy,
    );
    if (responseModel.status) {

      //store to List for show more data
      var newData = ProductModel.fromJson(jsonDecode(responseModel.responseJson));
      lastPage = newData.meta?.lastPage ?? lastPage;
      if (newData.data != null && newData.data!.isNotEmpty) {
        products.addAll(newData.data!);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    isMoreLoading = false;
    update();
  }
}
