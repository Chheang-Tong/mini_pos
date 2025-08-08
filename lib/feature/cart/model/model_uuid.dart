class UuidModel{
  UuidModel({Uuid? data}){
    _data=data;
  }
  UuidModel.fromJson(dynamic json){
    _data=json['data'] != null ? Uuid.fromJson(json['data']):null;
  }
  Uuid? _data;
  Uuid? get data=>_data;
  Map<String,dynamic>toJson(){
    final map=<String,dynamic>{};
    if(_data!=null){
      map['data']=_data?.toJson();
    }
    return map;
  }
}
class Uuid{
  Uuid({String? uuid}){
    _uuid=uuid;
  }
  Uuid.fromJson(dynamic json){
    _uuid=json['uuid'];
  }
  String? _uuid;
  String? get uuid=>_uuid;

  Map<String,dynamic>toJson(){
    final map=<String,dynamic>{};
    map['uuid']=_uuid;
    return map;
  }

}