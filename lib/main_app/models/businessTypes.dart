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