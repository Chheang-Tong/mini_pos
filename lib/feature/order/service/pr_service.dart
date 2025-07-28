
class ProductModel {
  List<Product> data;
  Links links;
  Meta meta;

  ProductModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}

class Product {
  int id;
  dynamic slug;
  String name;
  String? code;
  int price;
  bool isPin;
  String priceFormat;
  int quantity;
  int minimumOrder;
  SubtractStock subtractStock;
  OutOfStockStatus outOfStockStatus;
  DateAvailable dateAvailable;
  int sortOrder;
  bool status;
  bool isNew;
  dynamic viewed;
  bool isFavourite;
  bool reviewable;
  List<Image> images;
  dynamic promotion;
  String createdAt;
  String updatedAt;
  dynamic unit;
  dynamic eanCode;

  Product({
    required this.id,
    required this.slug,
    required this.name,
    required this.code,
    required this.price,
    required this.isPin,
    required this.priceFormat,
    required this.quantity,
    required this.minimumOrder,
    required this.subtractStock,
    required this.outOfStockStatus,
    required this.dateAvailable,
    required this.sortOrder,
    required this.status,
    required this.isNew,
    required this.viewed,
    required this.isFavourite,
    required this.reviewable,
    required this.images,
    required this.promotion,
    required this.createdAt,
    required this.updatedAt,
    required this.unit,
    required this.eanCode,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    code: json["code"],
    price: json["price"],
    isPin: json["is_pin"],
    priceFormat: json["price_format"],
    quantity: json["quantity"],
    minimumOrder: json["minimum_order"],
    subtractStock: subtractStockValues.map[json["subtract_stock"]]!,
    outOfStockStatus: outOfStockStatusValues.map[json["out_of_stock_status"]]!,
    dateAvailable: dateAvailableValues.map[json["date_available"]]!,
    sortOrder: json["sort_order"],
    status: json["status"],
    isNew: json["is_new"],
    viewed: json["viewed"],
    isFavourite: json["is_favourite"],
    reviewable: json["reviewable"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    promotion: json["promotion"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    unit: json["unit"],
    eanCode: json["ean_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "code": code,
    "price": price,
    "is_pin": isPin,
    "price_format": priceFormat,
    "quantity": quantity,
    "minimum_order": minimumOrder,
    "subtract_stock": subtractStockValues.reverse[subtractStock],
    "out_of_stock_status": outOfStockStatusValues.reverse[outOfStockStatus],
    "date_available": dateAvailableValues.reverse[dateAvailable],
    "sort_order": sortOrder,
    "status": status,
    "is_new": isNew,
    "viewed": viewed,
    "is_favourite": isFavourite,
    "reviewable": reviewable,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "promotion": promotion,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "unit": unit,
    "ean_code": eanCode,
  };
}

enum DateAvailable {
  THE_06102025,
  THE_13062025,
  THE_28072025
}

final dateAvailableValues = EnumValues({
  "06/10/2025": DateAvailable.THE_06102025,
  "13/06/2025": DateAvailable.THE_13062025,
  "28/07/2025": DateAvailable.THE_28072025
});

class Image {
  int id;
  String name;
  String imagePath;
  bool main;
  String imageUrl;

  Image({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.main,
    required this.imageUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    name: json["name"],
    imagePath: json["image_path"],
    main: json["main"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image_path": imagePath,
    "main": main,
    "image_url": imageUrl,
  };
}

enum OutOfStockStatus {
  IN_STOCK
}

final outOfStockStatusValues = EnumValues({
  "In Stock": OutOfStockStatus.IN_STOCK
});

enum SubtractStock {
  YES
}

final subtractStockValues = EnumValues({
  "yes": SubtractStock.YES
});

class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
