class BusinessType {
  BusinessType({
    this.id,
    this.name,
    this.count
  });

  String id;
  String name;
  int count;

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
    id: json["_id"] ?? '',
    name: json["name"] ?? '_',
    count: json["stores_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name
  };
}