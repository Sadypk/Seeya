import 'package:seeya/main_app/models/product_model.dart';

class CartModel{
  ProductModel product;
  int count;

  CartModel({
    this.product,
    this.count=1
  });
}