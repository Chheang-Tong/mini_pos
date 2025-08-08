class CartModel {
  CartModel({Cart? data}) {
    _data = data;
  }

  CartModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Cart.fromJson(json['data']) : null;
  }

  Cart? _data;
  Cart? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Cart {
  Cart({
    dynamic subTotalI,
    dynamic discountI,
    dynamic totalI,
    dynamic cartDiscountI,
    bool? isDiscountFixedI,
    dynamic shippingI,
    dynamic couponI,
    int? totalProductsI,
    int? totalQuantityI,
    List<Product>? products,
  }) {
    _subTotalI = subTotalI;
    _discountI = discountI;
    _totalI = totalI;
    _cartDiscountI = cartDiscountI;
    _isDiscountFixedI = isDiscountFixedI;
    _shippingI = shippingI;
    _couponI = couponI;
    _totalProductsI = totalProductsI;
    _totalQuantityI = totalQuantityI;
    _products = products;
  }

  Cart.fromJson(dynamic json) {
    _subTotalI = json['sub_total'];
    _discountI = json['discount'];
    _totalI = json['total'];
    _cartDiscountI = json['cart_discount'];
    _isDiscountFixedI = json['is_discount_fixed'];
    _shippingI = json['shipping'];
    _couponI = json['coupon'];
    _totalQuantityI = json['total_quantity'];
    _totalProductsI = json['total_products'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Product.fromJson(v));
      });
    }
  }

  dynamic _subTotalI;
  dynamic _discountI;
  dynamic _totalI;
  dynamic _cartDiscountI;
  bool? _isDiscountFixedI;
  dynamic _shippingI;
  dynamic _couponI;
  int? _totalProductsI;
  int? _totalQuantityI;
  List<Product>? _products;

  dynamic get subTotalI => _subTotalI;
  dynamic get discountI => _discountI;
  dynamic get totalI => _totalI;
  dynamic get cartDiscountI => _cartDiscountI;
  bool? get isDiscountFixedI => _isDiscountFixedI;
  dynamic get shippingI => _shippingI;
  dynamic get couponI => _couponI;
  int? get totalProductsI => _totalProductsI;
  int? get totalQuantityI => _totalQuantityI;
  List<Product>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sub_total'] = _subTotalI;
    map['discount'] = _discountI;
    map['total'] = _totalI;
    map['cart_discount'] = _cartDiscountI;
    map['is_discount_fixed'] = _isDiscountFixedI;
    map['shipping'] = _shippingI;
    map['coupon'] = _couponI;
    map['total_products'] = _totalProductsI;
    map['total_quantity'] = _totalQuantityI;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Cart copyWith({
    dynamic subTotalI,
    dynamic discountI,
    dynamic totalI,
    dynamic cartDiscountI,
    bool? isDiscountFixedI,
    dynamic shippingI,
    dynamic couponI,
    int? totalProductsI,
    int? totalQuantityI,
    List<Product>? products,
  }) {
    return Cart(
      subTotalI: subTotalI ?? _subTotalI,
      discountI: discountI ?? _discountI,
      totalI: totalI ?? _totalI,
      cartDiscountI: cartDiscountI ?? _cartDiscountI,
      isDiscountFixedI: isDiscountFixedI ?? _isDiscountFixedI,
      shippingI: shippingI ?? _shippingI,
      couponI: couponI ?? _couponI,
      totalProductsI: totalProductsI ?? _totalProductsI,
      totalQuantityI: totalQuantityI ?? _totalQuantityI,
      products: products ?? _products,
    );
  }
}

class Product {
  Product({
    int? cartId,
    int? id,
    String? name,
    dynamic code,
    dynamic price,
    dynamic total,
    dynamic subTotal,
    int? quantity,
    List<Option>? options,
    dynamic discount,
    bool? isDiscountFixed,
    String? unit,
  }) {
    _cartId = cartId;
    _id = id;
    _name = name;
    _code = code;
    _price = price;
    _total = total;
    _subTotal = subTotal;
    _quantity = quantity;
    _options = options;
    _discount = discount;
    _isDiscountFixed = isDiscountFixed;
    _unit = unit;
  }

  Product.fromJson(dynamic json) {
    _cartId = json['cart_id'];
    _id = json['id'];
    _name = json['name'];
    _code = json['code'];
    _price = json['price'];
    _total = json['total'];
    _subTotal = json['sub_total'];
    _quantity = json['quantity'];
    if (json['options'] != null) {
      _options = [];
      json['options'].forEach((v) {
        _options?.add(Option.fromJson(v));
      });
    } else {
      _options = [];
    }
    _discount = json['discount'];
    _isDiscountFixed = json['is_discount_fixed'];
    _unit = json['unit'];
  }

  int? _cartId;
  int? _id;
  String? _name;
  dynamic _code;
  dynamic _price;
  dynamic _total;
  dynamic _subTotal;
  int? _quantity;
  List<Option>? _options;
  dynamic _discount;
  bool? _isDiscountFixed;
  String? _unit;

  int? get cartId => _cartId;
  int? get id => _id;
  String? get name => _name;
  dynamic get code => _code;
  dynamic get price => _price;
  dynamic get total => _total;
  dynamic get subTotal => _subTotal;
  int? get quantity => _quantity;
  List<Option>? get options => _options;
  dynamic get discount => _discount;
  bool? get isDiscountFixed => _isDiscountFixed;
  String? get unit => _unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cart_id'] = _cartId;
    map['id'] = _id;
    map['name'] = _name;
    map['code'] = _code;
    map['price'] = _price;
    map['total'] = _total;
    map['sub_total'] = _subTotal;
    map['quantity'] = _quantity;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    map['discount'] = _discount;
    map['is_discount_fixed'] = _isDiscountFixed;
    map['unit'] = _unit;
    return map;
  }

  Product copyWith({
    int? cartId,
    int? id,
    String? name,
    dynamic code,
    dynamic price,
    dynamic total,
    dynamic subTotal,
    int? quantity,
    List<Option>? options,
    dynamic discount,
    bool? isDiscountFixed,
    String? unit,
  }) {
    return Product(
      cartId: cartId ?? _cartId,
      id: id ?? _id,
      name: name ?? _name,
      code: code ?? _code,
      price: price ?? _price,
      total: total ?? _total,
      subTotal: subTotal ?? _subTotal,
      quantity: quantity ?? _quantity,
      options: options ?? _options,
      discount: discount ?? _discount,
      isDiscountFixed: isDiscountFixed ?? _isDiscountFixed,
      unit: unit ?? _unit,
    );
  }
}

class Option {
  Option({
    String? name,
    Value? value,
  }) {
    _name = name;
    _value = value;
  }

  Option.fromJson(dynamic json) {
    _name = json['name'] ?? '';
    _value = json['value'] != null ? Value.fromJson(json['value']) : null;
  }

  String? _name;
  Value? _value;

  String? get name => _name;
  Value? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    if (_value != null) {
      map['value'] = _value?.toJson();
    }
    return map;
  }
}

class Value {
  Value({
    String? name,
    dynamic price,
  }) {
    _name = name;
    _price = price;
  }

  Value.fromJson(dynamic json) {
    _name = json['name'];
    _price = json['price'];
  }

  String? _name;
  dynamic _price;

  String? get name => _name;
  dynamic get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['price'] = _price;
    return map;
  }
}
