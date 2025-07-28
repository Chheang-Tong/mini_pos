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
import '/common/common.dart';
import '/feature/feature.dart';

class ProductController extends GetxController {
  ProductRepo productRepo;
  ProductController({required this.productRepo});
  final ScrollController scrollController=ScrollController();
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

  bool isLoading = true;
  bool isSubmitLoading = false;
  var currentPage = 1;
  var lastPage = 1;
  bool isMoreLoading = false; // <-- Flag for loading more

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


  Future<void> loadProduct({bool loadMore = false}) async {
    if (loadMore) {
      if (currentPage >= lastPage) return;
      isMoreLoading = true;
      update();
      await Future.delayed(const Duration(seconds: 5));
      currentPage++;

    } else {
      currentPage = 1;
      products.clear();
    }
    ResponseModel responseModel =
    await productRepo.getProduct(limit: 10, page: currentPage);
    if (responseModel.status) {
      // productModel =
      //     ProductModel.fromJson(jsonDecode(responseModel.responseJson));
      // lastPage = productModel.meta!.lastPage ?? lastPage;
      // if (productModel.data != null) {
      //   products.addAll(productModel.data!);
      // }
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
