class HomeFavModel {
  HomeFavModel({
    this.id,
    this.name,
    this.logo,
    this.defaultCashback,
  });

  String id;
  String name;
  String logo;
  int defaultCashback;

  factory HomeFavModel.fromJson(Map<String, dynamic> json) => HomeFavModel(
    id: json["_id"],
    name: json["name"],
    logo: json["logo"],
    defaultCashback: json["default_cashback"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "logo": logo,
    "default_cashback": defaultCashback,
  };
}