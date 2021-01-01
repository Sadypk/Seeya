import 'package:get/get.dart';

class ProductModel{
  int productId;
  String productName;
  String productDescription;
  String productImage;
  double productPrice;
  double cashBack;

  ProductModel({
    this.productId,
    this.productImage,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.cashBack
  });
}



