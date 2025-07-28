class WelModel {
  WelModel({
    int? totalRevenue,
    int? totalOrders,
}){
    _totalRevenue=totalRevenue ;
    _totalOrders=totalOrders;
  }

  WelModel.fromJson(dynamic json){
    _totalRevenue=json['total_revenue'];
    _totalOrders=json['total_orders'];
  }
  int ? _totalRevenue;
  int? _totalOrders;

  int? get totalRevenue =>_totalRevenue;
  int? get totalOrders=>_totalOrders;
  Map<String, dynamic> toJson(){
    final map = <String,dynamic>{};
    map['total_revenue']=_totalRevenue;
    map['total_orders']=_totalOrders;
    return map;
  }
}
