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

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["_id"],
    name: json["name"],
    logo: json["logo"],
    catalog: Catalog.fromJson(json["catalog"]),
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
    "logo": logo,
    "catalog": catalog.toJson(),
    "mrp": mrp,
    "selling_price": sellingPrice,
    "cashback": cashback,
    "cashback_percentage": cashbackPercentage,
    "details": details,
    "status": status,
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
    name: json["name"],
    id: json["_id"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "_id": id,
    "img": img,
  };
}