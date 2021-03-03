import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/main_app/models/productModel.dart';
import 'package:seeya/main_app/models/product_model.dart';
import 'package:seeya/main_app/models/userModel.dart';
import 'package:seeya/main_app/resources/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';

class MainRepo{

  /// gets all nearest restaurant based on users current location
  /// the user choose/ selected on the map in the beginning
  static const queryGetNearestStoreByCustomer = r'''
  query($lat: Float $lng: Float){
    getNearestStoreByCustomer(lat: $lat lng: $lng){
      error
      msg
      data{
        _id
        name
        businesstype{
          _id
          name
        }
        address{
          address
          location{
            lat
            lng
          }
        }
        logo
        default_cashback
        default_welcome_offer
        promotion_cashback
        promotion_welcome_offer
      }
    }
  }
  ''';
  static Future<List<StoreModel>> getAllNearestStore() async{
    try{
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
        document: gql(queryGetNearestStoreByCustomer),
        variables: {
          'lat' : UserViewModel.currentLocation.value.latitude,
          'lng' : UserViewModel.currentLocation.value.longitude
        }
      ));
      return List<StoreModel>.from(result.data['getNearestStoreByCustomer']['data'].map((x) => StoreModel.fromJson(x)));
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  /// get all linked store where the user and store
  /// has a wallet connection
  static const queryGetAllLinkedStoresByCustomer = r'''
  query{
    getAllLinkedStoresByCustomer{
      error
      msg
      data{
        _id
        name
        businesstype{
          _id
          name
        }
        address{
          address
          location{
            lat
            lng
          }
        }
        logo
        default_cashback
        default_welcome_offer
        promotion_cashback
        promotion_welcome_offer
      }
    }
  }
  ''';
  static Future<List<StoreModel>> getAllLinkedStores() async{

    try{
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
          document: gql(queryGetAllLinkedStoresByCustomer)
      ));
      return List<StoreModel>.from(result.data['getAllLinkedStoresByCustomer']['data'].map((x) => StoreModel.fromJson(x)));
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  /// gets all products of the nearest restaurants based on the current
  /// location the user choose/ selected on the map in the beginning
  static const queryGetAllProductsByCustomer = r'''
  query($lat: Float $lng: Float){
    getAllProductsByCustomer(lat: $lat lng: $lng){
      error
      msg
      data{
        _id
        name
        logo
        catalog{
          name
          _id
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
  }
  ''';
  static Future<List<ProductModel>> getAllProducts() async{

    try{
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
        document: gql(queryGetAllProductsByCustomer),
        variables: {
          'lat' : UserViewModel.currentLocation.value.latitude,
          'lng' : UserViewModel.currentLocation.value.longitude
        }
      ));
      return List<ProductModel>.from(result.data['getAllProductsByCustomer']['data'].map((x) => ProductModel.fromJson(x)));
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  /// sending a store id will return all the product with cashBack offer
  static const queryGetAllCashBackProducts = r'''
  query($storeID: ID){
    getAllCashbackProducts(store: $storeID){
      error
      msg
      data{
        _id
          name
          logo
          catalog{
            name
            _id
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
  }
  ''';
  static Future<List<ProductModel>> getAllCashBackProductsOfOneRestaurant(String storeID) async{

    try{
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
          document: gql(queryGetAllCashBackProducts),
          variables: {
            'storeID' : storeID
          }
      ));
      return List<ProductModel>.from(result.data['getAllCashbackProducts']['data'].map((x) => ProductModel.fromJson(x)));
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  /// get all not linked store where the user and store
  /// has not yet created a wallet connection
  static const queryGetAllNotLinkedStoresByCustomer = r'''
  query($lat: Float $lng: Float){
    getNearestStoresNotIntoWallet(lat: $lat lng: $lng){
      error
      msg
      data{
        _id
        name
        businesstype{
          _id
          name
        }
        address{
          address
          location{
            lat
            lng
          }
        }
        logo
        default_cashback
        default_welcome_offer
        promotion_cashback
        promotion_welcome_offer
      }
    }
  }
  ''';
  static Future<List<StoreModel>> getAllNotLinkedStores() async{

    try{
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
        document: gql(queryGetAllNotLinkedStoresByCustomer),
        variables: {
          'lat' : UserViewModel.currentLocation.value.latitude,
          'lng' : UserViewModel.currentLocation.value.longitude
        }
      ));
      return List<StoreModel>.from(result.data['getNearestStoresNotIntoWallet']['data'].map((x) => StoreModel.fromJson(x)));
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  /// get all the info of the customer by sending the token
  /// al ready getting all the info when signing in just in case
  static const queryGetCustomerInfoWithToken = r'''
  query($token: String){
    verifyCustomerToken(token: $token){
      error
      msg
      token
      data{
        _id
        first_name
        last_name
        mobile
        email
        addresses{
          address
          location{
            lat
            lng
          }
          status
        }
        balance
        logo
        date_of_birth
        male_or_female
      }
    }
  }
  ''';
  static Future<UserModel> getCustomerInfoWithToken(String token) async{

    try{
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
          document: gql(queryGetAllProductsByCustomer),
          variables: {
            'token' : token,
          }
      ));
      return UserModel.fromJson(result.data['verifyCustomerToken']['data']);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  /// add all nearest restaurnt of the user to his wallet or whatever he calls
  /// one click api, returns if it was sucessfull or not
  static const mutateAddAllNearestRestaurant = r'''
  mutation($lat: Float $lng: Float){
    addStoreByLocation(lat: $lat lng:$lng){
      error
      msg
    }
  }
  ''';
  static Future<bool> addAllRestaurant() async{
    try{
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.mutate(MutationOptions(
          document: gql(mutateAddAllNearestRestaurant),
          variables: {
            'lat' : UserViewModel.currentLocation.value.latitude,
            'lng' : UserViewModel.currentLocation.value.longitude
          }
      ));
      return result.data['addStoreByLocation']['error'];
    }catch(e){
      print(e.toString());
      return true;
    }
  }

  /// adds a single restaurant balance to his own wallet
  /// if the store has promotion welcome offer add that
  /// otherwise add the default
  static const mutateAddSingleStoreToWallet = r'''
  mutation($id: ID $balance: Float){
    addSingleStore(store: $id balance:$balance){
      error
      msg
    }
  }
  ''';
  static const queryGetOneRestaurantWelcomeOffer = r'''
  query($id: ID){
    getOneStore(_id: $id){
      error
      msg
      data{
        promotion_welcome_offer_status
        promotion_welcome_offer
        default_welcome_offer
      }
    }
  }
  ''';
  static Future<bool> addSingleStoreToWallet(String storeID) async{
    try{
      double balance;
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);

      QueryResult result1 = await client.query(QueryOptions(
          document: gql(queryGetOneRestaurantWelcomeOffer),
          variables: {
            'id' : storeID
          }
      ));

      if(result1.data['getOneStore']['data']['promotion_welcome_offer_status'] == 'active'){
        balance = result1.data['getOneStore']['promotion_welcome_offer'].toDouble();
      }else{
        balance = result1.data['getOneStore']['default_welcome_offer'].toDouble();
      }

      QueryResult result2 = await client.mutate(MutationOptions(
          document: gql(mutateAddSingleStoreToWallet),
          variables: {
            'id' : storeID,
            'balance' : balance
          }
      ));



      return result2.data['addSingleStore']['error'];
    }catch(e){
      print(e.toString());
      return true;
    }
  }


  ///update customer information
  ///if you do not want to update something send that string as empty string
  ///it will not update, do not send null
  ///empty string == that field will not get updated
  static const mutateUpdateCustomerInfo = r'''
  mutation($firstName: String $lastName: String $email: String $image: String $dob: String $gender: String $address: String $lat: Float $lng: Float){
    updateCustomerInformation(customerInput:{
      first_name: $firstName
      last_name: $lastName
      email: $email
      logo: $image
      date_of_birth: $dob
      male_or_female: $gender
      address:{
        address: $address
        location:{
          lat: $lat
          lng: $lng
        }}
    }){
      error
      msg
    }
  }
  ''';
  static Future<bool> updateCustomerInfo(String firstName, String lastName, String email, String image, String dob, String gender) async{
    try{
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result2 = await client.mutate(MutationOptions(
          document: gql(mutateUpdateCustomerInfo),
          variables: {
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "image": image,
            "dob": dob,
            "gender": gender,
            "address": 'do not touch this address',
            "lat": 11.22,
            "lng": 33.44
          }
      ));



      return result2.data['updateCustomerInformation']['error'];
    }catch(e){
      print(e.toString());
      return true;
    }
  }
}


