import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_model.dart';
import '/common/common.dart';
import '/feature/cart/cart.dart';

class CartController extends GetxController {
  CartRepo cartRepo;
  CartController({required this.cartRepo});

  bool loading = true;
  CartModel cartModel = CartModel();
  UuidModel uuidModel = UuidModel();
  String? savedUuid; // Store loaded UUID
  final TextEditingController searchController = TextEditingController(), discountCtr = TextEditingController();
  int discountIndex = 0, methodIndex = 0;
  Map<String, String> discount = {
    "assets/images/dollar.svg": "Fix Discount",
    "assets/images/percent.svg": "Percentage",
  };
  Map<String, String> method = {
    "assets/images/cash.svg": "Cash",
    "assets/images/bank.svg": "Bank",
  };
  List<String> bank = ['ABA', 'ACLEDA', 'WOORY'];

  @override
  void onInit() {
    searchController.text = 'Walk-in Customer';
    discountCtr.text = '';
    _ensureUuid();
    super.onInit();
  }

  // === clear ===
  clear(){
    discountCtr.text='';
    update();
  }

  // === DISCOUNT & PAYMENT SELECTION ===
  void isSelect(int index) {
    discountIndex = index;
    debugPrint('Discount selection changed. Index: $discountIndex (isDefault: ${discountIndex == 0})');
    update();
  }
  // === true -> money and false -> percentage ===
  bool get isFixedDiscount => discountIndex == 0;


  //  === select method ===
  void metSelect(int index) {
    methodIndex = index;
    update();
  }

  // === ENSURE UUID IS AVAILABLE ===
  Future<void> _ensureUuid() async {
    final prefs = await SharedPreferences.getInstance();
    savedUuid = prefs.getString('cart_uuid');
    if (savedUuid == null || savedUuid!.isEmpty) {
      await fetchAndSaveUuid();
    } else {
      debugPrint('Loaded UUID from storage: $savedUuid');
    }
  }

  // === FETCH NEW UUID AND SAVE ===
  Future<void> fetchAndSaveUuid() async {
    ResponseModel responseModel = await cartRepo.getUuid();
    if (responseModel.status) {
      uuidModel = UuidModel.fromJson(jsonDecode(responseModel.responseJson));
      if (uuidModel.data != null && uuidModel.data!.uuid != null && uuidModel.data!.uuid!.isNotEmpty) {
        savedUuid = uuidModel.data!.uuid!;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('cart_uuid', savedUuid!);
        debugPrint('Fetched and saved new UUID: $savedUuid');
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
      debugPrint(responseModel.message);
    }
    loading = false;
    update();
  }

  // === CLEAR UUID (FOR RESET PURPOSES) ===
  Future<void> clearUuid() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart_uuid');
    savedUuid = null;
    debugPrint('UUID cleared from storage');
    await fetchAndSaveUuid();
  }

  // === INITIAL DATA ===
  Future<void> initialData({bool shouldLoading = true}) async {
    loading = shouldLoading;
    update();
    if (savedUuid == null) {
      await _ensureUuid();
    }
    if (savedUuid != null) {
      await loadCart(uuid: savedUuid!);
    }
    loading = false;
    update();
  }

  // === LOAD CART ===
  Future<void> loadCart({required String uuid, bool silent = false}) async {
    if (!silent) {
      loading = true;
      update();
    }
    ResponseModel responseModel = await cartRepo.getCart(uuid: uuid);
    if (responseModel.status) {
      final data = jsonDecode(responseModel.responseJson);
      if (data['data'] == null || (data['data']['products'] as List).isEmpty) {
        cartModel = CartModel(); // Reset to empty
      } else {
        cartModel = CartModel.fromJson(data);
      }
    } else {
      // If cart not found, clear the model
      cartModel = CartModel();
      debugPrint('ErrorList: ${responseModel.message}');
    }
    loading = false;
    update();
  }


  // === ADD TO CART ===
  Future<bool> addToCart({required int productId, required int qty, List<Map<String, dynamic>>? option}) async {
    if (savedUuid == null) await _ensureUuid();
    if (savedUuid == null) return false;
    loading = true;
    update();
    ResponseModel responseModel =
    await cartRepo.addToCart(uuid: savedUuid!, productId: productId, qty: qty, option: option);
    if (responseModel.status) {
      await loadCart(uuid: savedUuid!);
      update();
      return true;
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
      debugPrint(responseModel.message);
      update();
      return false;
    }
  }


  // === Remove All Product ===
  Future<void> rmAllProduct() async {
    loading = true;
    update();
    ResponseModel responseModel =
    await cartRepo.rmProductAll(uuid: savedUuid!);
    if (responseModel.status) {
      cartModel=CartModel();
      update();
      await loadCart(uuid: savedUuid!, silent: true);
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);

    }
    loading=false;
    update();
  }


  Future<void> plus({required int index}) async {
    var cart = cartModel.data!;
    var currentQty = cart.products![index].quantity ?? 0;
    var updatedCart = updateProductInCart(cart, index, currentQty + 1);

    cartModel = CartModel(data: updatedCart);
    update(); // update UI immediately
    // API call
    final response = await cartRepo.updateQty(
      uuid: savedUuid!,
      cartId: cart.products![index].cartId!,
      qty: currentQty + 1,
    );

    if (!response.status) {
      await loadCart(uuid: savedUuid!, silent: true);
      update();
      CustomSnackBar.error(
        errorList: [response.message.isNotEmpty == false ? response.message : 'Out of Stock'],
      );
    }
  }

  Future<void> minus({required int index}) async {
    var cart = cartModel.data!;
    var currentQty = cart.products![index].quantity ?? 0;
    if (currentQty <= 1) return;

    var updatedCart = updateProductInCart(cart, index, currentQty - 1);

    cartModel = CartModel(data: updatedCart);
    update(); // update UI immediately

    // API call
    final response = await cartRepo.updateQty(
      uuid: savedUuid!,
      cartId: cart.products![index].cartId!,
      qty: currentQty - 1,
    );

    if (!response.status) {
      await loadCart(uuid: savedUuid!, silent: true);
      update();
      CustomSnackBar.error(errorList: [response.message]);
    }
  }

  updateProductInCart(Cart cart, int index, int newQuantity) {
    var products = List<Product>.from(cart.products ?? []);
    var p = products[index];

    // Calculate product discount
    double price = parseToDouble(p.price);
    double discount = parseToDouble(p.discount);
    bool isDiscountFixed = p.isDiscountFixed ?? false;

    // Discounted price per unit
    double discountedPrice = isDiscountFixed
        ? (price - discount)
        : price - (price * (discount / 100));

    if (discountedPrice < 0) discountedPrice = 0;

    // New subtotal after discount
    double newSubTotal = discountedPrice * newQuantity;

    products[index] = p.copyWith(
      quantity: newQuantity,
      subTotal: newSubTotal,
    );

    return recalculateCart(cart.copyWith(products: products));
  }

  double parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Cart recalculateCart(Cart cart) {
    var products = cart.products ?? [];


    products = products.map((p) {
      double price = parseToDouble(p.price);
      double discount = parseToDouble(p.discount);
      int quantity = p.quantity ?? 0;
      bool isFixed = p.isDiscountFixed ?? false;
      // for product
      double originalSubTotal =price * quantity;

      double discountedTotal = isFixed
          ? originalSubTotal - discount
          : originalSubTotal - (originalSubTotal * (discount / 100));

      if (discountedTotal < 0) discountedTotal = 0;

      return p.copyWith(
        subTotal: originalSubTotal,
        total: discountedTotal,
      );
    }).toList();

    // Sum all product subtotals
    double newSubTotal = products.fold<double>(0.0, (sum, p) => sum + parseToDouble(p.total));

    // for cart
    double cartDiscountValue = parseToDouble(cart.cartDiscountI);
    bool isCartDiscountFixed = cart.isDiscountFixedI ?? false;

    double discountAmount = isCartDiscountFixed
        ? cartDiscountValue
        : (newSubTotal * (cartDiscountValue / 100));

    if (discountAmount > newSubTotal) discountAmount = newSubTotal;

    double newTotal = newSubTotal - discountAmount;

    var newTotalQuantity = products.fold<int>(0, (sum, p) => sum + (p.quantity ?? 0));
    var newTotalProducts = products.length;

    return cart.copyWith(
      products: products,
      subTotalI: newSubTotal,
      discountI: discountAmount,
      cartDiscountI: cart.cartDiscountI,
      isDiscountFixedI: isCartDiscountFixed,
      totalQuantityI: newTotalQuantity,
      totalProductsI: newTotalProducts,
      totalI: newTotal,
    );
  }



  // === UPDATE QTY ===
  Future<void> updateQty({required int cartId, required int qty}) async {
    ResponseModel responseModel = await cartRepo.updateQty(uuid: savedUuid!, cartId: cartId, qty: qty);
    if (responseModel.status) {
      await loadCart(uuid: savedUuid!, silent: true);
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
      debugPrint(responseModel.message);
    }
    loading = false;
    update();
  }

  Future<void>disCountInvoice({required String discount,required bool isFix})async{
    ResponseModel responseModel =
    await cartRepo.addDiscountInvoice(uuid: savedUuid!, discount:discount, isFix: isFix);
    if (responseModel.status) {
      await loadCart(uuid: savedUuid!, silent: true);
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
      debugPrint(responseModel.message);
    }
    loading = false;
    update();
  }
  Future<void>disCountItem({required String discount,required String cartId,required bool isFix})async{
    ResponseModel responseModel =
    await cartRepo.addDiscountItem(uuid: savedUuid!, cartId: cartId, discount: discount, isFix: isFix);
    if (responseModel.status) {
      await loadCart(uuid: savedUuid!, silent: true);
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
      debugPrint(responseModel.message);
    }
    loading = false;
    update();
  }

}
