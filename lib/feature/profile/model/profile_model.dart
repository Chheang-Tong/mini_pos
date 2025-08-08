class ProfileModel {
  ProfileModel({
    Profile? data,
  }) {
    _data = data;
  }

  ProfileModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Profile.fromJson(json['data']) : null;
  }

  Profile? _data;

  Profile? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Profile {
  Profile({
    int? id,
    String? firstname,
    String? lastname,
    String? gender,
    String? email,
    bool? status,
    String? type,
    bool? isAdmin,
    dynamic imagePath,
    dynamic image,
    bool? isSocialUser,
    dynamic linkedinId,
    dynamic fbId,
    dynamic googleId,
    dynamic appleId,
    bool? isPhoneRegister,
    int? storeId,
    bool? storeStatus,
    String? storeAddress,
    dynamic storeDomain,
    String? storeSubDomain,
    String? storeName,
    String? storePhone,
    String? storeLogo,
    List<Role>? roles,
    List<String>? permissions,
    String? address,
    String? phone,
  }) {
    _id = id;
    _firstname = firstname;
    _lastname = lastname;
    _gender = gender;
    _email = email;
    _status = status;
    _type = type;
    _isAdmin = isAdmin;
    _imagePath = imagePath;
    _image = image;
    _isSocialUser = isSocialUser;
    _linkedinId = linkedinId;
    _fbId = fbId;
    _googleId = googleId;
    _appleId = appleId;
    _isPhoneRegister = isPhoneRegister;
    _storeId = storeId;
    _storeStatus = storeStatus;
    _storeAddress = storeAddress;
    _storeDomain = storeDomain;
    _storeSubDomain = storeSubDomain;
    _storeName = storeName;
    _storePhone = storePhone;
    _storeLogo = storeLogo;
    _roles = roles;
    _permissions = permissions;
    _address = address;
    _phone = phone;
  }

  Profile.fromJson(dynamic json) {
    _id = json['id'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _gender = json['gender'];
    _email = json['email'];
    _status = json['status'];
    _type = json['type'];
    _isAdmin = json['is_admin'];
    _imagePath = json['image_path'];
    _image = json['image'];
    _isSocialUser = json['is_social_user'];
    _linkedinId = json['linkedin_id'];
    _fbId = json['fb_id'];
    _googleId = json['google_id'];
    _appleId = json['apple_id'];
    _isPhoneRegister = json['is_phone_register'];
    _storeId = json['store_id'];
    _storeStatus = json['store_status'];
    _storeAddress = json['store_address'];
    _storeDomain = json['store_domain'];
    _storeSubDomain = json['store_sub_domain'];
    _storeName = json['store_name'];
    _storePhone = json['store_phone'];
    _storeLogo = json['store_logo'];
    if (json['roles'] != null) {
      _roles = [];
      json['roles'].forEach((v) {
        _roles?.add(Role.fromJson(v));
      });
    }
    _permissions = json['permissions'] != null ? List<String>.from(json['permissions']) : [];
    _address = json['address'];
    _phone = json['phone'];
  }

  int? _id;
  String? _firstname;
  String? _lastname;
  String? _gender;
  String? _email;
  bool? _status;
  String? _type;
  bool? _isAdmin;
  dynamic _imagePath;
  dynamic _image;
  bool? _isSocialUser;
  dynamic _linkedinId;
  dynamic _fbId;
  dynamic _googleId;
  dynamic _appleId;
  bool? _isPhoneRegister;
  int? _storeId;
  bool? _storeStatus;
  String? _storeAddress;
  dynamic _storeDomain;
  String? _storeSubDomain;
  String? _storeName;
  String? _storePhone;
  String? _storeLogo;
  List<Role>? _roles;
  List<String>? _permissions;
  String? _address;
  String? _phone;

  int? get id => _id;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get gender => _gender;
  String? get email => _email;
  bool? get status => _status;
  String? get type => _type;
  bool? get isAdmin => _isAdmin;
  dynamic get imagePath => _imagePath;
  dynamic get image => _image;
  bool? get isSocialUser => _isSocialUser;
  dynamic get linkedinId => _linkedinId;
  dynamic get fbId => _fbId;
  dynamic get googleId => _googleId;
  dynamic get appleId => _appleId;
  bool? get isPhoneRegister => _isPhoneRegister;
  int? get storeId => _storeId;
  bool? get storeStatus => _storeStatus;
  String? get storeAddress => _storeAddress;
  dynamic get storeDomain => _storeDomain;
  String? get storeSubDomain => _storeSubDomain;
  String? get storeName => _storeName;
  String? get storePhone => _storePhone;
  String? get storeLogo => _storeLogo;
  List<Role>? get roles => _roles;
  List<String>? get permissions => _permissions;
  String? get address => _address;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['gender'] = _gender;
    map['email'] = _email;
    map['status'] = _status;
    map['type'] = _type;
    map['is_admin'] = _isAdmin;
    map['image_path'] = _imagePath;
    map['image'] = _image;
    map['is_social_user'] = _isSocialUser;
    map['linkedin_id'] = _linkedinId;
    map['fb_id'] = _fbId;
    map['google_id'] = _googleId;
    map['apple_id'] = _appleId;
    map['is_phone_register'] = _isPhoneRegister;
    map['store_id'] = _storeId;
    map['store_status'] = _storeStatus;
    map['store_address'] = _storeAddress;
    map['store_domain'] = _storeDomain;
    map['store_sub_domain'] = _storeSubDomain;
    map['store_name'] = _storeName;
    map['store_phone'] = _storePhone;
    map['store_logo'] = _storeLogo;
    if (_roles != null) {
      map['roles'] = _roles?.map((v) => v.toJson()).toList();
    }
    map['permissions'] = _permissions;
    map['address'] = _address;
    map['phone'] = _phone;
    return map;
  }
}

class Role {
  Role({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Role.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
