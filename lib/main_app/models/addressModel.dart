class AddressModel {
  AddressModel({
    this.address,
    this.location,
    this.status,
    this.title,
    this.id
  });

  String id;
  String address;
  String title;
  bool status;
  LocationModel location;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["_id"],
    address: json["address"] == null ? '' : json["address"],
    status: json["status"] == null ? '' : json["status"],
    title: json["title"] == null ? '' : json["title"],
    location: json["location"] == null ? LocationModel() : LocationModel.fromJson(json["location"]),
  );
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