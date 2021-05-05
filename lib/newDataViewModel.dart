import 'package:seeya/features/store/models/storeModel.dart';
import 'package:seeya/features/home_screen/models/homeFavStoreModel.dart';
import 'package:seeya/main_app/models/45_model.dart';
import 'package:seeya/main_app/models/businessTypes.dart';

class NewDataViewModel{
  static List<BusinessType> businessTypes = [];
  static List<HomeFavModel> homeFavStores = [];
  static List<dynamic> homeSpecialDataRecent = [];
  static List<dynamic> homeSpecialDataPharmacy = [];
  static List<dynamic> homeSpecialDataGrocery = [];
  static List<dynamic> homeSpecialDataFresh = [];
  static List<dynamic> homeSpecialDataRestaurant = [];
  static FavPageDataModel grocery;
  static FavPageDataModel fresh;
  static FavPageDataModel restaurant;
  static FavPageDataModel pharmacy;
}