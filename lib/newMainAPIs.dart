import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:seeya/features/home_screen/view/all_offers_near_you.dart';
import 'package:seeya/features/scan_receipt/view/45_fav_stores_main_page.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'newDataViewModel.dart';
import 'package:seeya/main_app/models/45_model.dart';
import 'package:seeya/features/home_screen/models/homeFavStoreModel.dart';

class NewApi{
  static var logger = Logger();

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
      logger.i(result.data);
      if(!result.data['getAllBusinessTypes']['error']){
        NewDataViewModel.businessTypes = List.from(result.data['getAllBusinessTypes']['data'].map((type)=>BusinessType.fromJson(type)));
      }
    }catch(e){
      print(e.toString());
    }
  }

  static Future<void> getHomeFavShops() async{
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
      logger.i(result.data);
      if(!result.data['getHomePageFavoriteShops']['error']){
        NewDataViewModel.homeFavStores = List.from(result.data['getHomePageFavoriteShops']['data'].map((type)=>HomeFavModel.fromJson(type)));
      }
    }catch(e){
      print(e.toString());
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

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(document: gql(_query),variables: variables));
      logger.i(result.data);
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
  String businesstypeId;

  factory BoomModel.fromJson(Map<String, dynamic> json) => BoomModel(
    id: json["_id"],
    name: json["name"],
    logo: json["logo"],
    flag: json["flag"],
    distance: json["distance"],
    defaultWelcomeOffer: json["default_welcome_offer"],
    promotionWelcomeOfferStatus: json["promotion_welcome_offer_status"],
    promotionWelcomeOffer: json["promotion_welcome_offer"],
    promotionWelcomeOfferDate: OfferDateModel.fromJson(json["promotion_welcome_offer_date"]),
    businesstypeId: json["businesstype"]['_id'],
  );
}