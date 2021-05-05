import 'package:get/get.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/main_app/models/businessTypes.dart';


class NearestStoreViewModel extends GetxController{
  var storeList = <StoreModel>[
    StoreModel(
      name: 'Adidas',
      address: StoreAddressModel(
        address: 'Virat Nagar'
      ),
      businesstype: BusinessType(
        name: 'Business Type Name'
      ),
      defaultCashback: 2.0,
      promotionCashback: 5.0,
      defaultWelcomeOffer: 3.0,
      logo: 'https://i0.wp.com/deltacollegian.net/wp-content/uploads/2017/05/adidas.png?fit=880%2C660'
    ),
    StoreModel(
        name: 'Adidas',
        address: StoreAddressModel(
            address: 'Virat Nagar'
        ),
        businesstype: BusinessType(
            name: 'Business Type Name'
        ),
        defaultCashback: 2.0,
        promotionCashback: 5.0,
        defaultWelcomeOffer: 3.0,
        logo: 'https://weartesters.com/wp-content/uploads/2016/07/adidas-logo-e1468257076328.jpg'
    ),
  ].obs;
}