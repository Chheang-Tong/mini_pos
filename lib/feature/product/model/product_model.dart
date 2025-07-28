class ProductModel {
  ProductModel({
    List<Product>? data,
    Links? links,
    Meta? meta,
  }) {
    _data = data;
    _links = links;
    _meta = meta;
  }

  ProductModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Product.fromJson(v));
      });
    }
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<Product>? _data;
  Links? _links;
  Meta? _meta;

  List<Product>? get data => _data;
  Links? get links => _links;
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_links != null) {
      map['links'] = _links?.toJson();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}

class Product {
  Product({
    int? id,
    dynamic slug,
    String? name,
    String? code,
    int? price,
    bool? isPin,
    String? priceFormat,
    int? quantity,
    int? minimumOrder,
    String? subtractStock,
    String? outOfStockStatus,
    String? dateAvailable,
    int? sortOrder,
    bool? status,
    bool? isNew,
    dynamic viewed,
    bool? isFavourite,
    bool? reviewable,
    List<ImageItem>? images,
    dynamic promotion,
    String? createdAt,
    String? updatedAt,
    dynamic unit,
    dynamic eanCode,
  }) {
    _id = id;
    _slug = slug;
    _name = name;
    _code = code;
    _price = price;
    _isPin = isPin;
    _priceFormat = priceFormat;
    _quantity = quantity;
    _minimumOrder = minimumOrder;
    _subtractStock = subtractStock;
    _outOfStockStatus = outOfStockStatus;
    _dateAvailable = dateAvailable;
    _sortOrder = sortOrder;
    _status = status;
    _isNew = isNew;
    _viewed = viewed;
    _isFavourite = isFavourite;
    _reviewable = reviewable;
    _images = images;
    _promotion = promotion;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _unit = unit;
    _eanCode = eanCode;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _slug = json['slug'];
    _name = json['name'];
    _code = json['code'];
    _price = json['price'];
    _isPin = json['is_pin'];
    _priceFormat = json['price_format'];
    _quantity = json['quantity'];
    _minimumOrder = json['minimum_order'];
    _subtractStock = json['subtract_stock'];
    _outOfStockStatus = json['out_of_stock_status'];
    _dateAvailable = json['date_available'];
    _sortOrder = json['sort_order'];
    _status = json['status'];
    _isNew = json['is_new'];
    _viewed = json['viewed'];
    _isFavourite = json['is_favourite'];
    _reviewable = json['reviewable'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(ImageItem.fromJson(v));
      });
    }
    _promotion = json['promotion'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _unit = json['unit'];
    _eanCode = json['ean_code'];
  }

  int? _id;
  dynamic _slug;
  String? _name;
  String? _code;
  int? _price;
  bool? _isPin;
  String? _priceFormat;
  int? _quantity;
  int? _minimumOrder;
  String? _subtractStock;
  String? _outOfStockStatus;
  String? _dateAvailable;
  int? _sortOrder;
  bool? _status;
  bool? _isNew;
  dynamic _viewed;
  bool? _isFavourite;
  bool? _reviewable;
  List<ImageItem>? _images;
  dynamic _promotion;
  String? _createdAt;
  String? _updatedAt;
  dynamic _unit;
  dynamic _eanCode;

  int? get id => _id;
  dynamic get slug => _slug;
  String? get name => _name;
  String? get code => _code;
  int? get price => _price;
  bool? get isPin => _isPin;
  String? get priceFormat => _priceFormat;
  int? get quantity => _quantity;
  int? get minimumOrder => _minimumOrder;
  String? get subtractStock => _subtractStock;
  String? get outOfStockStatus => _outOfStockStatus;
  String? get dateAvailable => _dateAvailable;
  int? get sortOrder => _sortOrder;
  bool? get status => _status;
  bool? get isNew => _isNew;
  dynamic get viewed => _viewed;
  bool? get isFavourite => _isFavourite;
  bool? get reviewable => _reviewable;
  List<ImageItem>? get images => _images;
  dynamic get promotion => _promotion;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get unit => _unit;
  dynamic get eanCode => _eanCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['slug'] = _slug;
    map['name'] = _name;
    map['code'] = _code;
    map['price'] = _price;
    map['is_pin'] = _isPin;
    map['price_format'] = _priceFormat;
    map['quantity'] = _quantity;
    map['minimum_order'] = _minimumOrder;
    map['subtract_stock'] = _subtractStock;
    map['out_of_stock_status'] = _outOfStockStatus;
    map['date_available'] = _dateAvailable;
    map['sort_order'] = _sortOrder;
    map['status'] = _status;
    map['is_new'] = _isNew;
    map['viewed'] = _viewed;
    map['is_favourite'] = _isFavourite;
    map['reviewable'] = _reviewable;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    map['promotion'] = _promotion;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['unit'] = _unit;
    map['ean_code'] = _eanCode;
    return map;
  }
}

class ImageItem {
  ImageItem({
    int? id,
    String? name,
    String? imagePath,
    bool? main,
    String? imageUrl,
  }) {
    _id = id;
    _name = name;
    _imagePath = imagePath;
    _main = main;
    _imageUrl = imageUrl;
  }

  ImageItem.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imagePath = json['image_path'];
    _main = json['main'];
    _imageUrl = json['image_url'];
  }

  int? _id;
  String? _name;
  String? _imagePath;
  bool? _main;
  String? _imageUrl;

  int? get id => _id;
  String? get name => _name;
  String? get imagePath => _imagePath;
  bool? get main => _main;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image_path'] = _imagePath;
    map['main'] = _main;
    map['image_url'] = _imageUrl;
    return map;
  }
}

class Links {
  Links({
    String? first,
    String? last,
    dynamic prev,
    dynamic next,
  }) {
    _first = first;
    _last = last;
    _prev = prev;
    _next = next;
  }

  Links.fromJson(dynamic json) {
    _first = json['first'];
    _last = json['last'];
    _prev = json['prev'];
    _next = json['next'];
  }

  String? _first;
  String? _last;
  dynamic _prev;
  dynamic _next;

  String? get first => _first;
  String? get last => _last;
  dynamic get prev => _prev;
  dynamic get next => _next;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first'] = _first;
    map['last'] = _last;
    map['prev'] = _prev;
    map['next'] = _next;
    return map;
  }
}

class Meta {
  Meta({
    int? currentPage,
    int? from,
    int? lastPage,
    List<Link>? links,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) {
    _currentPage = currentPage;
    _from = from;
    _lastPage = lastPage;
    _links = links;
    _path = path;
    _perPage = perPage;
    _to = to;
    _total = total;
  }

  Meta.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _from = json['from'];
    _lastPage = json['last_page'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Link.fromJson(v));
      });
    }
    _path = json['path'];
    _perPage = json['per_page'];
    _to = json['to'];
    _total = json['total'];
  }

  int? _currentPage;
  int? _from;
  int? _lastPage;
  List<Link>? _links;
  String? _path;
  int? _perPage;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  int? get from => _from;
  int? get lastPage => _lastPage;
  List<Link>? get links => _links;
  String? get path => _path;
  int? get perPage => _perPage;
  int? get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}

class Link {
  Link({
    String? url,
    String? label,
    bool? active,
  }) {
    _url = url;
    _label = label;
    _active = active;
  }

  Link.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }

  String? _url;
  String? _label;
  bool? _active;

  String? get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }
}
