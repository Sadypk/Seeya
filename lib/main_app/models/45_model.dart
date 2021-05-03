class FavPageDataModel {
  FavPageDataModel({
    this.id,
    this.itemCount,
    this.catalogs,
    this.products,
    this.stores,
  });

  String id;
  int itemCount;
  List<CatalogModel> catalogs;
  List<ProductModel> products;
  List<StoreModel> stores;

  factory FavPageDataModel.fromJson(Map<String, dynamic> json) => FavPageDataModel(
    id: json["_id"],
    itemCount: json["item_count"],
    catalogs: List<CatalogModel>.from(json["catalogs"].map((x) => CatalogModel.fromJson(x))),
    products: List<ProductModel>.from(json["products"].map((x) => ProductModel.fromJson(x))),
    stores: List<StoreModel>.from(json["stores"].map((x) => StoreModel.fromJson(x))),
  );
}

class CatalogModel {
  CatalogModel({
    this.id,
    this.name,
    this.img,
  });

  String id;
  String name;
  String img;

  factory CatalogModel.fromJson(Map<String, dynamic> json) => CatalogModel(
    id: json["_id"],
    name: json["name"],
    img: json["img"],
  );
}

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.logo,
    this.store,
    this.cashback,
    this.expiryDate,
    this.businesstype,
    this.catId,
  });

  String id;
  String name;
  String catId;
  String logo;
  StoreModel store;
  num cashback;
  DateTime expiryDate;
  String businesstype;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["_id"],
    name: json["name"],
    catId: json["catalog"]['_id'],
    logo: json["logo"],
    store: json["store"],
    cashback: json["cashback"],
    expiryDate: json["expiry_date"] == null ? null : DateTime.fromMillisecondsSinceEpoch(int.parse(json["expiry_date"])),
    businesstype: json["businesstype"]['_id'],
  );
}

class StoreModel {
  StoreModel({
  this.id,
  this.name,
  this.logo,
  this.businesstype,
  this.defaultCashback,
  this.promotionCashback,
  this.promotionCashbackStatus,
  this.promotionCashbackDate,
  this.promotionWelcomeOffer,
  this.promotionWelcomeOfferStatus,
  this.promotionWelcomeOfferDate,
  });

  String id;
  String name;
  String logo;
  String businesstype;
  num defaultCashback;
  num promotionCashback;
  String promotionCashbackStatus;
  OfferDateModel promotionCashbackDate;
  num promotionWelcomeOffer;
  String promotionWelcomeOfferStatus;
  OfferDateModel promotionWelcomeOfferDate;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    id: json["_id"],
    name: json["name"],
    logo: json["logo"],
    businesstype: json["businesstype"]['_id'],
    defaultCashback: json["default_cashback"],
    promotionCashback: json["promotion_cashback"],
    promotionCashbackStatus: json["promotion_cashback_status"],
    promotionCashbackDate: OfferDateModel.fromJson(json["promotion_cashback_date"]),
    promotionWelcomeOffer: json["promotion_welcome_offer"],
    promotionWelcomeOfferStatus: json["promotion_welcome_offer_status"],
    promotionWelcomeOfferDate: OfferDateModel.fromJson(json["promotion_welcome_offer_date"]),
  );
}


class OfferDateModel {
  OfferDateModel({
  this.startDate,
  this.endDate,
  });

  DateTime startDate;
  DateTime endDate;

  factory OfferDateModel.fromJson(Map<String, dynamic> json) => OfferDateModel(
    startDate: json["start_date"] == null ? null : DateTime.fromMillisecondsSinceEpoch(int.parse(json["start_date"])),
    endDate: json["end_date"] == null ? null : DateTime.fromMillisecondsSinceEpoch(int.parse(json["end_date"])),
  );
}

