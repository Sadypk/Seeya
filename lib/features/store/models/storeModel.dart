import 'package:seeya/main_app/models/addressModel.dart';

class StoreModel {
  StoreModel({
    this.name,
    this.id,
    this.businesstype,
    this.address,
    this.logo,
    this.defaultCashback,
    this.defaultWelcomeOffer,
    this.promotionCashback,
    this.promotionWelcomeOffer,
  });

  String name;
  String id;
  BusinessType businesstype;
  StoreAddressModel address;
  String logo;
  double defaultCashback;
  double defaultWelcomeOffer;
  double promotionCashback;
  int promotionWelcomeOffer;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    name: json["name"] == null ? 'null' : json["name"],
    id: json["_id"] == null ? 'null' : json["_id"],
    businesstype: json["businesstype"] == null ? BusinessType() : BusinessType.fromJson(json["businesstype"]),
    address: json["address"] == null ? StoreAddressModel() : StoreAddressModel.fromJson(json["address"]),
    logo: json["logo"] ?? '',
    defaultCashback: json["default_cashback"] != null ?double.parse(json["default_cashback"].toString()) : 0.0,
    defaultWelcomeOffer: json["default_welcome_offer"] != null ?double.parse(json["default_welcome_offer"].toString()) : 0.0,
    promotionCashback: json["promotion_cashback"] != null ?double.parse(json["promotion_cashback"].toString()) : 0.0,
    promotionWelcomeOffer: json["promotion_welcome_offer"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "_id": id == null ? null : id,
    "businesstype": businesstype == null ? null : businesstype.toJson(),
    "address": address == null ? null : address.toJson(),
    "logo": logo == null ? null : logo,
    "default_cashback": defaultCashback == null ? null : defaultCashback,
    "default_welcome_offer": defaultWelcomeOffer == null ? null : defaultWelcomeOffer,
    "promotion_cashback": promotionCashback == null ? null : promotionCashback,
    "promotion_welcome_offer": promotionWelcomeOffer,
  };
}


class BusinessType {
  BusinessType({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
    id: json["_id"] ?? '',
    name: json["name"] ?? '_',
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name,
  };
}

class StoreAddressModel {
  StoreAddressModel({
    this.address,
    this.location,
  });

  String address;
  LocationModel location;

  factory StoreAddressModel.fromJson(Map<String, dynamic> json) => StoreAddressModel(
    address: json["address"] == null ? '' : json["address"],
    location: json["location"] == null ? LocationModel() : LocationModel.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? null : address,
    "location": location == null ? null : location.toJson(),
  };
}