class GetAllBusinessTypes {
  GetAllBusinessTypes({
    this.error,
    this.msg,
    this.data,
  });

  bool error;
  String msg;
  List<BusinessTypesData> data;

  factory GetAllBusinessTypes.fromJson(Map<String, dynamic> json) => GetAllBusinessTypes(
    error: json["error"],
    msg: json["msg"],
    data: List<BusinessTypesData>.from(json["data"].map((x) => BusinessTypesData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BusinessTypesData {
  BusinessTypesData({
    this.name,
    this.id,
  });

  String name;
  String id;

  factory BusinessTypesData.fromJson(Map<String, dynamic> json) => BusinessTypesData(
    name: json["name"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "_id": id,
  };
}
