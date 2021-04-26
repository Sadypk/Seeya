class HomePageSpecialOfferAndCategoryData {
  HomePageSpecialOfferAndCategoryData({
    this.products,
    this.stores,
  });

  List<ProductElement> products;
  List<StoreElement> stores;

  factory HomePageSpecialOfferAndCategoryData.fromJson(Map<String, dynamic> json) => HomePageSpecialOfferAndCategoryData(
    products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
    stores: List<StoreElement>.from(json["stores"].map((x) => StoreElement.fromJson(x))),
  );
}

class ProductElement {
  ProductElement({
    this.id,
    this.name,
    this.storeId,
    this.cashback,
    this.sellingPrice,
    this.expiryDate,
  });

  String id;
  String name;
  String storeId;
  double cashback;
  double sellingPrice;
  int expiryDate;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    id: json["_id"],
    name: json["name"],
    storeId: json["store"]['_id'],
    cashback: double.parse(json["cashback"].toString()),
    sellingPrice: double.parse(json["selling_price"].toString()),
    expiryDate: int.parse(json["expiry_date"]),
  );
}

class StoreElement {
  StoreElement({
    this.id,
    this.name,
    this.promotionCashbackStatus,
    this.promotionCashback,
    this.defaultCashback,
    this.promotionCashbackDate,
  });

  String id;
  String name;
  String promotionCashbackStatus;
  double promotionCashback;
  double defaultCashback;
  dynamic promotionCashbackDate;

  factory StoreElement.fromJson(Map<String, dynamic> json) => StoreElement(
    id: json["_id"],
    name: json["name"],
    promotionCashbackStatus: json["promotion_cashback_status"],
    promotionCashback: json["promotion_cashback"] != null ? double.parse(json["promotion_cashback"].toString()) : 0.0,
    defaultCashback: double.parse(json["default_cashback"]),
    promotionCashbackDate: json["promotion_cashback_date"],
  );
}
