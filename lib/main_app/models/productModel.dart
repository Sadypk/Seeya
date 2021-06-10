class GetOrderOnlinePageProductsData {
  GetOrderOnlinePageProductsData({
    this.error,
    this.msg,
    this.data,
  });

  bool error;
  String msg;
  StoreData data;

  factory GetOrderOnlinePageProductsData.fromJson(Map<String, dynamic> json) => GetOrderOnlinePageProductsData(
    error: json["error"],
    msg: json["msg"],
    data: StoreData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": data.toJson(),
  };
}

class StoreData {
  StoreData({
    this.products,
    this.walletAmount,
  });

  List<ProductModel> products;
  int walletAmount;

  factory StoreData.fromJson(Map<String, dynamic> json) => StoreData(
    products: List<ProductModel>.from(json["products"].map((x) => ProductModel.fromJson(x))),
    walletAmount: json["wallet_amount"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "wallet_amount": walletAmount,
  };
}


class RawProduct{
  String name;
  int quantity;

  RawProduct({this.name,this.quantity = 1});
  Map<String, dynamic> toJson() => {
    "name": name,
    'quantity' : quantity ?? 1
  };
}
class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.logo,
    this.catalog,
    this.mrp,
    this.sellingPrice,
    this.cashback,
    this.cashbackPercentage,
    this.details,
    this.status,
    this.quantity = 1,
  });

  String id;
  String name;
  String logo;
  Catalog catalog;
  double mrp;
  double sellingPrice;
  double cashback;
  int cashbackPercentage;
  String details;
  String status;
  int quantity;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["_id"],
    name: json["name"] ?? '',
    logo: json["logo"],
    catalog: json["catalog"] == null ? null : Catalog.fromJson(json["catalog"]),
    mrp: json["mrp"].toDouble(),
    sellingPrice: json["selling_price"].toDouble(),
    cashback: json["cashback"].toDouble(),
    cashbackPercentage: json["cashback_percentage"],
    details: json["details"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "mrp": mrp,
    "selling_price": sellingPrice,
    "cashback": cashback,
    'quantity' : quantity ?? 1
  };
}

class Catalog {
  Catalog({
    this.name,
    this.id,
    this.img,
  });

  String name;
  String id;
  String img;

  factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
    name: json["name"] ?? '',
    id: json["_id"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "_id": id,
    "img": img,
  };
}