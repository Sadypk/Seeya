class ProductModel{
  int productId;
  String productName;
  String productImage;
  double productPrice;

  ProductModel({
    this.productId,
    this.productImage,
    this.productName,
    this.productPrice
  });
}



List<ProductModel> productList2 = [
  ProductModel(
    productId: 21,
    productImage: 'https://mcdonalds.com.au/sites/mcdonalds.com.au/files/Product-Details-BigMac-mobile-201904.jpg',
    productName: 'Big Mac',
    productPrice: 29.99,
  ),
  ProductModel(
    productId: 22,
    productImage: 'https://www.mcdonalds.com/content/dam/usa/nfl/nutrition/items/regular/desktop/t-mcdonalds-Fries-Small-Medium.jpg',
    productName: 'McDonalds Fries',
    productPrice: 9.99,
  ),
];

List<ProductModel> productList3 = [
  ProductModel(
    productId: 31,
    productImage: 'https://recipefairy.com/wp-content/uploads/2020/07/kfc-chicken-500x375.jpg',
    productName: 'Chicken Fry',
    productPrice: 19.99,
  ),
  ProductModel(
    productId: 32,
    productImage: 'https://assets.newatlas.com/dims4/default/7c0af90/2147483647/strip/true/crop/1372x915+0+0/resize/1372x915!/quality/90/?url=http%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2Fb8%2F01%2F42fb621748ceb2a3c56f158d373f%2Fbucket-tenders-laying.jpeg',
    productName: 'Chicken Nuggets',
    productPrice: 10,
  ),
];