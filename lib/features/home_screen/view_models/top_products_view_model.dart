import 'package:get/get.dart';
import 'package:seeya/main_app/models/product_model.dart';

class TopProductsViewModel extends GetxController{
  var productList = <ProductModel>[
    ProductModel(
        productId: 21,
        productImage: 'https://mcdonalds.com.au/sites/mcdonalds.com.au/files/Product-Details-BigMac-mobile-201904.jpg',
        productName: 'Big Mac',
        productPrice: 29.99,
        productDescription: '\$1.00 cash back',
        cashBack: 1.5
    ),
    ProductModel(
        productId: 22,
        productImage: 'https://www.mcdonalds.com/content/dam/usa/nfl/nutrition/items/regular/desktop/t-mcdonalds-Fries-Small-Medium.jpg',
        productName: 'McDonalds Fries',
        productPrice: 9.99,
        productDescription: '\$0.75 cash back',
        cashBack: 3
    ),
    ProductModel(
        productId: 31,
        productImage: 'https://recipefairy.com/wp-content/uploads/2020/07/kfc-chicken-500x375.jpg',
        productName: 'Chicken Fry',
        productPrice: 14.99,
        cashBack: 2
    ),
    ProductModel(
        productId: 32,
        productImage: 'https://assets.newatlas.com/dims4/default/7c0af90/2147483647/strip/true/crop/1372x915+0+0/resize/1372x915!/quality/90/?url=http%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2Fb8%2F01%2F42fb621748ceb2a3c56f158d373f%2Fbucket-tenders-laying.jpeg',
        productName: 'Chicken Nuggets',
        productDescription: '\$0.50 cash back',
        productPrice: 12,
        cashBack: 1
    ),
  ].obs;
}