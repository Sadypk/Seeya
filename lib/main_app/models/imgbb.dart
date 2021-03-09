class ImgbbResponseModel {
  ImgbbResponseModel({
    this.data,
    this.success,
    this.status,
  });

  ImageUrls data;
  bool success;
  int status;

  factory ImgbbResponseModel.fromJson(Map<String, dynamic> json) => ImgbbResponseModel(
    data: ImageUrls.fromJson(json["data"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "success": success,
    "status": status,
  };
}

class ImageUrls {
  ImageUrls({
    this.displayUrl,
    this.deleteUrl,
  });

  String displayUrl;
  String deleteUrl;

  factory ImageUrls.fromJson(Map<String, dynamic> json) => ImageUrls(
    displayUrl: json["display_url"],
    deleteUrl: json["delete_url"],
  );

  Map<String, dynamic> toJson() => {
    "display_url": displayUrl,
    "delete_url": deleteUrl,
  };
}