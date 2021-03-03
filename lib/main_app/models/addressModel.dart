class AddressModel {
  AddressModel({
    this.address,
    this.location,
    this.status,
  });

  String address;
  bool status;
  LocationModel location;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    address: json["address"] == null ? '' : json["address"],
    status: json["status"] == null ? '' : json["status"],
    location: json["location"] == null ? LocationModel() : LocationModel.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? null : address,
    "status": address == null ? null : status,
    "location": location == null ? null : location.toJson(),
  };
}

class LocationModel {
  LocationModel({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    lat: json["lat"] == null ? 0.0 : json["lat"].toDouble(),
    lng: json["lng"] == null ? 0.0 : json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
  };
}