class Address {
  Address({
    this.address,
    this.location,
  });

  String address;
  Location location;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"] == null ? '' : json["address"],
    location: json["location"] == null ? Location() : Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? null : address,
    "location": location == null ? null : location.toJson(),
  };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"] == null ? 0.0 : json["lat"].toDouble(),
    lng: json["lng"] == null ? 0.0 : json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
  };
}