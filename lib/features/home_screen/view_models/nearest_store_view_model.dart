import 'package:get/get.dart';
import 'package:seeya/features/store/models/store_model.dart';


class NearestStoreViewModel extends GetxController{
  var storeList = <StoreModel>[
    StoreModel(
        storeId: 1,
        storeLocation: 'Mars',
        storeName: 'McDonalds',
        productList: [],
        cashBackList: [6,2],
        storeImage: 'https://www.bestdesigns.co/uploads/inspiration_images/4531/990__1511456189_555_McDonald\'s.png',
      distance: 17
    ),
    StoreModel(
        storeId: 2,
        storeLocation: 'Saturn',
        storeName: 'Adidas',
        productList: [],
        cashBackList: [33],
        storeImage: 'https://i.pinimg.com/originals/b6/e2/ef/b6e2ef894ef8e63a8a3e8c35a6e6144a.png',
        distance: 3
    ),
    StoreModel(
        storeId: 3,
        storeName: 'Nike',
        productList: [],
        cashBackList: [10,5],
        storeImage: 'https://i.insider.com/53d29d5c6bb3f7a80617ada8?width=1100&format=jpeg&auto=webp',
        distance: 9
    ),
    // StoreModel(
    //     storeId: 1,
    //     storeLocation: 'Mars',
    //     storeName: 'McDonalds',
    //     productList: [],
    //     cashBackList: [6,2],
    //     storeImage: 'https://www.bestdesigns.co/uploads/inspiration_images/4531/990__1511456189_555_McDonald\'s.png'
    // ),
    // StoreModel(
    //     storeId: 2,
    //     storeLocation: 'Saturn',
    //     storeName: 'Adidas',
    //     productList: [],
    //     cashBackList: [15,7],
    //     storeImage: 'https://i.pinimg.com/originals/b6/e2/ef/b6e2ef894ef8e63a8a3e8c35a6e6144a.png'
    // ),
    // StoreModel(
    //     storeId: 3,
    //     storeLocation: 'Mars',
    //     storeName: 'Nike',
    //     productList: [],
    //     cashBackList: [10,5],
    //     storeImage: 'https://logos-world.net/wp-content/uploads/2020/04/Nike-Logo.png'
    // )
  ].obs;
}