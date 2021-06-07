import 'dart:io';
import 'package:seeya/main_app/util/imagePicker.dart';

import 'main_app/models/productModel.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:seeya/features/home_screen/view/all_offers_near_you.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'newDataViewModel.dart';
import 'package:seeya/main_app/models/45_model.dart';
import 'package:seeya/features/home_screen/models/homeFavStoreModel.dart';
import 'package:seeya/main_app/models/businessTypes.dart';

class NewApi{
  static var logger = Logger();

  static Future<bool> addFirebaseToken(String token) async{
    final mutation = r'''
    mutation($token: String){
      addFirebaseTokenToCustomer(firebase_token: $token){
        error
        msg
      }
    }
    ''';

    final data = {
      'token' : token
    };

    try{

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      final response = await client.mutate(MutationOptions(document: gql(mutation), variables: data));

      return response.data['addFirebaseTokenToStore']['error'];
    }catch(e){
      return true;
    }
  }


  static Future<void> getAllCategories() async{
    final _query = r'''query{
     getAllBusinessTypes{
      error
      data{
        _id
        name
        }
      }
    }''';

    try{
     GraphQLClient client = GqlConfig.getClient();
      QueryResult result = await client.query(QueryOptions(document: gql(_query)));
      // logger.i(result.data);
      if(!result.data['getAllBusinessTypes']['error']){
        NewDataViewModel.businessTypes = List.from(result.data['getAllBusinessTypes']['data'].map((type)=>BusinessType.fromJson(type)));
      }
    }catch(e){
      print(e.toString());
    }
  }

  static Future<int> getHomeFavShops() async{
    final _query = r'''query($lat : Float $lng: Float){
    getHomePageFavoriteShops(lat: $lat, lng:$lng){
      error
      msg
      data{
        _id
        name
        logo
        default_cashback
      }
    }
  }''';

    try{

      final variables = {
        'lat' : UserViewModel.currentLocation.value.latitude,
        'lng' : UserViewModel.currentLocation.value.longitude,
      };

     GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));
      // logger.i(result.data);
      if(!result.data['getHomePageFavoriteShops']['error']){
        List<HomeFavModel> data = List.from(result.data['getHomePageFavoriteShops']['data'].map((type)=>HomeFavModel.fromJson(type)));
        NewDataViewModel.homeFavStores = data;
        return data.length;
      }else{
        return 0;
      }
    }catch(e){
      print(e.toString());
      return 0;
    }
  }

  static Future<List<dynamic>> getHomePageSpecialOfferAndCategoryData(String bType, [int pNum]) async{
    final _query = r'''query($lat: Float $lng: Float $bType: ID $pSize: Int $pNum: Int){
  getHomePageSpecialOfferAndCategoryData(
    lat: $lat
    lng: $lng
    businesstype: $bType
    page_size: $pSize
    page_number: $pNum
  ){
    error
    msg
    data{
      products{
        logo
        _id
        name
        store{
          _id
          name
        }
        cashback
        selling_price
        expiry_date
      }
      stores{
        _id
        name
        logo
        promotion_cashback_status
        promotion_cashback
        default_cashback
        promotion_cashback_date{
          start_date
          end_date
        }
      }
    }
  }
}''';

    try{
      final variables = {
        "lat": UserViewModel.currentLocation.value.latitude,
        "lng": UserViewModel.currentLocation.value.longitude,
        "bType": bType,
        "pSize": 100,
        "pNum": pNum ?? 1
      };

     GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));
      List<dynamic> data = [];
      if(!result.data['getHomePageSpecialOfferAndCategoryData']['error']){
        data.addAll(result.data['getHomePageSpecialOfferAndCategoryData']['data']['products'].where((data) => DateTime.fromMillisecondsSinceEpoch(int.parse(data['expiry_date'])).isAfter(DateTime.now())));
        data.addAll(result.data['getHomePageSpecialOfferAndCategoryData']['data']['stores'].where((data) => data['promotion_cashback_status'] == 'active' && DateTime.fromMillisecondsSinceEpoch(int.parse(data['promotion_cashback_date']['end_date'])).isAfter(DateTime.now())));
        data.shuffle();
        return data;
      }else{
        return [];
      }
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  static Future<void> get45_FavStoreMainScreenData() async{
    final _query = r'''query($lat : Float $lng: Float){
  getFavoritePageData(lat: $lat lng: $lng){
    error
    msg
    data{
      Fresh{
        _id
        item_count
        catalogs{
          _id
          name
          img
        }
        products{
          _id
          name
          logo
          store{
            _id
            name
          }
          cashback
          expiry_date
          businesstype{
            _id
          }
          catalog{
            _id
          }
        }
        stores{
          _id
          name
          businesstype{
            _id
          }
          logo
          default_cashback
          promotion_cashback
          promotion_cashback_status
          promotion_cashback_date{
            start_date
            end_date
          }
          promotion_welcome_offer
          promotion_welcome_offer_status
          promotion_welcome_offer_date{
            start_date
            end_date
          }
        }
      }
      Grocery{
        _id
        item_count
        catalogs{
          _id
          name
          img
        }
        products{
          _id
          name
          logo
          store{
            _id
            name
          }
          catalog{
            _id
          }
          cashback
          expiry_date
          businesstype{
            _id
          }
        }
        stores{
          _id
          name
          businesstype{
            _id
          }
          logo
          default_cashback
          promotion_cashback
          promotion_cashback_status
          promotion_cashback_date{
            start_date
            end_date
          }
          promotion_welcome_offer
          promotion_welcome_offer_status
          promotion_welcome_offer_date{
            start_date
            end_date
          }
        }
      }
      Restaurant{
        _id
        item_count
        catalogs{
          _id
          name
          img
        }
        products{
          _id
          name
          logo
          store{
            _id
            name
          }
          catalog{
            _id
          }
          cashback
          expiry_date
          businesstype{
            _id
          }
        }
        stores{
          _id
          name
          logo
          businesstype{
            _id
          }
          default_cashback
          promotion_cashback
          promotion_cashback_status
          promotion_cashback_date{
            start_date
            end_date
          }
          promotion_welcome_offer
          promotion_welcome_offer_status
          promotion_welcome_offer_date{
            start_date
            end_date
          }
        }
      }
      Pharmacy{
        _id
        item_count
        catalogs{
          _id
          name
          img
        }
        products{
          _id
          name
          logo
          store{
            _id
            name
          }
          catalog{
            _id
          }
          cashback
          expiry_date
          businesstype{
            _id
          }
        }
        stores{
          _id
          name
          logo
          businesstype{
            _id
          }
          default_cashback
          promotion_cashback
          promotion_cashback_status
          promotion_cashback_date{
            start_date
            end_date
          }
          promotion_welcome_offer
          promotion_welcome_offer_status
          promotion_welcome_offer_date{
            start_date
            end_date
          }
        }
      }
    }
  }
}''';

    try{

      final variables = {
        'lat': UserViewModel.currentLocation.value.latitude,
        'lng': UserViewModel.currentLocation.value.longitude
      };

      print(variables);

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));
      // logger.i(result.data);
      if(!result.data['getFavoritePageData']['error']){
        NewDataViewModel.grocery = FavPageDataModel.fromJson(result.data['getFavoritePageData']['data']['Grocery']);
        NewDataViewModel.fresh = FavPageDataModel.fromJson(result.data['getFavoritePageData']['data']['Fresh']);
        NewDataViewModel.restaurant = FavPageDataModel.fromJson(result.data['getFavoritePageData']['data']['Restaurant']);
        NewDataViewModel.pharmacy = FavPageDataModel.fromJson(result.data['getFavoritePageData']['data']['Pharmacy']);
      }
    }catch(e){
      print(e.toString());
      print("e.toString()");
    }
  }

  static Future<List<BoomModel>> get39_AllOffersNearYouData() async{
    final _query = r'''query($lat: Float $lng: Float){
  getClaimRewardsPageData(lat: $lat lng: $lng){
    error
    msg
    data{
      stores{
        _id
        name
        logo
        flag
        distance
        default_welcome_offer
        promotion_welcome_offer_status
        promotion_welcome_offer
        promotion_welcome_offer_date{
          start_date
          end_date
        }
        businesstype{
          _id
          name
          image
        }
      }
    }
  }
}''';

    try{

      final variables = {
        'lat': UserViewModel.currentLocation.value.latitude,
        'lng': UserViewModel.currentLocation.value.longitude
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));
      if(!result.data['getClaimRewardsPageData']['error']){
        return List<BoomModel>.from(result.data['getClaimRewardsPageData']['data']['stores'].map((type) => BoomModel.fromJson(type)));

      }else{
        return null;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static get39_BtnAddAll() async{
    final _query = r'''mutation($data: [AddStoreToWalletInput]){
  addMultipleStoreToWallet(addMultipleStoresToWallet:$data){
    error
    msg
  }
}''';

    try{

      List<Map<String, dynamic>> data = [];

      offersNearYouStores.forEach((element) {

        num offer = element.defaultWelcomeOffer;
        final today = DateTime.now();
        if(element.promotionWelcomeOfferStatus == 'active'){
          if(element.promotionWelcomeOfferDate.startDate.isBefore(today) &&  element.promotionWelcomeOfferDate.endDate.isAfter(today)){
            offer =element.promotionWelcomeOffer;
          }
        }

        data.add({
          'store' : element.id,
          'balance' : offer,
          'lat' : UserViewModel.currentLocation.value.latitude,
          'lng' : UserViewModel.currentLocation.value.longitude,
        });
      });

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.mutate(MutationOptions(document: gql(_query),variables: {
        'data' : data
      }));
      return result.data['addMultipleStoreToWallet'];
    }catch(e){
      print(e.toString());
      print('hgere');
      return null;
    }
  }

  static Future<List<BoomModel>> scanReceiptsFavStores({int pageNumber}) async{
    final _query = r'''query($lat : Float $lng: Float $pageNumber: Int){
  getScanReceiptPageMyFavoriteStoresData(
    lat: $lat
    lng: $lng
    page_size: 100
    page_number: $pageNumber
  ){
    error
    msg
    data{
      name
      logo
      _id
      default_cashback
      default_welcome_offer
      promotion_cashback
      promotion_welcome_offer
      promotion_cashback_status
      promotion_welcome_offer_status
      promotion_cashback_date{
        start_date
        end_date
      }
      promotion_welcome_offer_date{
        start_date
        end_date
      }
      businesstype{
        _id
      }
    }
  }
}''';

    try{

      final variables = {
        'lat': UserViewModel.currentLocation.value.latitude,
        'lng': UserViewModel.currentLocation.value.longitude,
        'pageNumber' : pageNumber ?? 1
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));

      if(!result.data['getScanReceiptPageMyFavoriteStoresData']['error']){
        return List<BoomModel>.from(result.data['getScanReceiptPageMyFavoriteStoresData']['data'].map((type) => BoomModel.fromJson(type)));
      }else{
        return null;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future<List<BoomModel>> scanReceiptNearMeStoreData({int, pageNumber, String businessType}) async{
    final _query = r'''query($lat : Float $lng: Float $pageNumber: Int $businessType: ID){
  getScanReceiptPageNearMeStoresData(
    lat: $lat
    lng: $lng
    page_size: 100
    page_number: $pageNumber
    businesstype: $businessType
  ){
    error
    msg
    data{
      name
      logo
      _id
      default_cashback
      default_welcome_offer
      promotion_cashback
      promotion_welcome_offer
      promotion_cashback_status
      promotion_welcome_offer_status
      promotion_cashback_date{
        start_date
        end_date
      }
      promotion_welcome_offer_date{
        start_date
        end_date
      }
      businesstype{
        _id
      }
    }
  }
}''';

    try{

      final variables = {
        'lat': UserViewModel.currentLocation.value.latitude,
        'lng': UserViewModel.currentLocation.value.longitude,
        'pageNumber' : pageNumber ?? 1,
        'businessType': businessType ?? ''
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));

      if(!result.data['getScanReceiptPageNearMeStoresData']['error']){
        return List<BoomModel>.from(result.data['getScanReceiptPageNearMeStoresData']['data'].map((type) => BoomModel.fromJson(type)));
      }else{
        return null;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future<List<BoomModel>> scanReceiptsBannerFavStores({String bType, String cType}) async{
    final _query = r'''query($lat : Float $lng: Float $bType: ID $cType: ID){
  getScanReceiptBannerPageMyFavoriteStoresData(
    lat: $lat
    lng: $lng
    businesstype: $bType
    catalog: $cType
  ){
    error
    msg
    data{
      name
      logo
      _id
      default_cashback
      default_welcome_offer
      promotion_cashback
      promotion_welcome_offer
      promotion_cashback_status
      promotion_welcome_offer_status
      promotion_cashback_date{
        start_date
        end_date
      }
      promotion_welcome_offer_date{
        start_date
        end_date
      }
      businesstype{
        _id
      }
    }
  }
}''';

    try{

      final variables = {
        'lat': UserViewModel.currentLocation.value.latitude,
        'lng': UserViewModel.currentLocation.value.longitude,
        'bType' : bType ?? '',
        'cType' : cType ?? ''
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));

      if(!result.data['getScanReceiptBannerPageMyFavoriteStoresData']['error']){
        return List<BoomModel>.from(result.data['getScanReceiptBannerPageMyFavoriteStoresData']['data'].map((type) => BoomModel.fromJson(type)));
      }else{
        return null;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future<List<BoomModel>> scanReceiptBannerNearMeStoreData({String bType, String cType}) async{
    final _query = r'''query($lat : Float $lng: Float $bType: ID $cType: ID){
  getScanReceiptBannerPageNearMeStoresData(
    lat: $lat
    lng: $lng
    businesstype: $bType
    catalog: $cType
  ){
    error
    msg
    data{
      name
      logo
      _id
      default_cashback
      default_welcome_offer
      promotion_cashback
      promotion_welcome_offer
      promotion_cashback_status
      promotion_welcome_offer_status
      promotion_cashback_date{
        start_date
        end_date
      }
      promotion_welcome_offer_date{
        start_date
        end_date
      }
      businesstype{
        _id
      }
    }
  }
}''';

    try{

      final variables = {
        'lat': UserViewModel.currentLocation.value.latitude,
        'lng': UserViewModel.currentLocation.value.longitude,
        'bType' : bType ?? '',
        'cType' : cType ?? ''
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));

      if(!result.data['getScanReceiptBannerPageNearMeStoresData']['error']){
        return List<BoomModel>.from(result.data['getScanReceiptBannerPageNearMeStoresData']['data'].map((type) => BoomModel.fromJson(type)));
      }else{
        return null;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future<List<BusinessType>> scanReceiptCategoryCountData([int, pageNumber, String businessType]) async{
    final _query = r'''query($lat : Float $lng: Float){
  getScanReceiptBannerPageCategoryCountData(
    lat: $lat
    lng: $lng
  ){
    error
    msg
    data{
      _id
      name
      stores_count
    }
  }
}''';

    try{

      final variables = {
        'lat': UserViewModel.currentLocation.value.latitude,
        'lng': UserViewModel.currentLocation.value.longitude
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));

      if(!result.data['getScanReceiptBannerPageCategoryCountData']['error']){
        return List<BusinessType>.from(result.data['getScanReceiptBannerPageCategoryCountData']['data'].map((type) => BusinessType.fromJson(type)));
      }else{
        return null;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future<List<CatalogModel>> getCatalogByBusinessID(String id) async{
    final _query = r'''query($id: ID){
  getAllCatalog(businesstype: $id){
    error
    msg
    data{
      _id
      name
      img
    }
  }
}''';

    try{

      final variables = {
        'id': id
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));
      if(!result.data['getAllCatalog']['error']){
        return List<CatalogModel>.from(result.data['getAllCatalog']['data'].map((type) => CatalogModel.fromJson(type)));
      }else{
        return [];
      }
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  static Future<List<ProductModel>> getCashBackProducts(String id) async{
    final _query = r'''query($storeId: ID){
  getAllCashbackProducts(store: $storeId){
    error
    msg
    data{
      _id
      name
      logo
      catalog{
        _id
        name
        img
      }
      mrp
      selling_price
      cashback
      cashback_percentage
      details
      status

    }
  }
}''';

    try{

      final variables = {
        'storeId': id
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));
      if(!result.data['getAllCashbackProducts']['error']){
        return List<ProductModel>.from(result.data['getAllCashbackProducts']['data'].map((type) => ProductModel.fromJson(type)));
      }else{
        return [];
      }
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  static Future<bool> placeOrder({List<File> images, BoomModel store, var products, double total}) async{
    final mutation = r'''
    mutation($image: String $storeId: ID $products: [OrderProduct] $total: Float $cashback: Float){
      placeOrder(orderInput:{
        order_type: "receipt"
        receipt: $image
        store: $storeId
        products: $products
        total: $total
        cashback_percentage: $cashback
        lat: 22.22
        lng: 22.21
      }){
        error
        msg
      }
    }
    ''';

    try{

      List<String> imageLinks = [];

      for (File image in images) {
        imageLinks.add(await ImageHelper.uploadImage(image));
      }

      double cashBack = store.defaultCashbackOffer.toDouble();
      final today = DateTime.now();
      if(store.promotionCashbackOfferStatus == 'active' && store.promotionCashbackOfferDate.startDate.isBefore(today) && store.promotionCashbackOfferDate.endDate.isAfter(today)){
        cashBack = store.promotionCashbackOffer.toDouble();
      }

      // TODO sending only one image

      final variables = {
        'image' : imageLinks[0],
        'products' : List.from(products.map((e) => e.toJson())),
        'storeId' : store.id,
        'total' : total,
        'cashback' : cashBack
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(mutation),variables: variables));

      print(result.data);

      return result.data['placeOrder']['error'];
    }catch(e){
      print(e.toString());
      return true;
    }
  }

}

class BoomModel {
  BoomModel({
    this.id,
    this.name,
    this.logo,
    this.flag,
    this.distance,
    this.defaultWelcomeOffer,
    this.promotionWelcomeOfferStatus,
    this.promotionWelcomeOffer,
    this.promotionWelcomeOfferDate,
    this.businesstypeId,
    this.defaultCashbackOffer,
    this.promotionCashbackOfferStatus,
    this.promotionCashbackOffer,
    this.promotionCashbackOfferDate,
    this.calculated_distance,
    this.store_type
  });

  String id;
  String name;
  String logo;
  String flag;
  num distance;
  num defaultWelcomeOffer;
  String promotionWelcomeOfferStatus;
  num promotionWelcomeOffer;
  OfferDateModel promotionWelcomeOfferDate;
  num defaultCashbackOffer;
  String promotionCashbackOfferStatus;
  num promotionCashbackOffer;
  OfferDateModel promotionCashbackOfferDate;
  String businesstypeId;
  double calculated_distance;
  String store_type;

  factory BoomModel.fromJson(Map<String, dynamic> json) => BoomModel(
    id: json["_id"],
    name: json["name"],
    logo: json["logo"],
    flag: json["flag"],
    distance: json["distance"],
    defaultWelcomeOffer: json["default_welcome_offer"],
    promotionWelcomeOfferStatus: json["promotion_welcome_offer_status"],
    promotionWelcomeOffer: json["promotion_welcome_offer"],
    promotionWelcomeOfferDate: json["promotion_welcome_offer_date"] == null ? null : OfferDateModel.fromJson(json["promotion_welcome_offer_date"]),
    defaultCashbackOffer: json["default_cashback"],
    promotionCashbackOfferStatus: json["promotion_cashback_status"],
    promotionCashbackOffer: json["promotion_cashback"],
    promotionCashbackOfferDate: json["promotion_cashback_date"] == null ? null : OfferDateModel.fromJson(json["promotion_cashback_date"]),
    businesstypeId: json["businesstype"]['_id'],
    calculated_distance: json["calculated_distance"] == null ? null : json["calculated_distance"],
    store_type: json["store_type"] == null ? null : json["store_type"],
  );
}