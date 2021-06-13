import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/util/snack.dart';

import '../../../newMainAPIs.dart';

class MySpecialOffers {
  static getMySpecialOffers() async {
    final mySpecialOffers = r'''
query($lat:Float,$lng:Float){
  getOrderOnlinePageSpecialOffersStoresData(lat: $lat lng: $lng){
    error
    msg
    data{
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
      default_cashback
      promotion_cashback_status
      promotion_cashback
      promotion_cashback_date{
        start_date
        end_date
      }
      businesstype{
        _id
      }
      calculated_distance
      store_type
    }
  }
}
  ''';
    try {
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(mySpecialOffers),
          variables: {
            "lat": UserViewModel.currentLocation.value.latitude,
            "lng": UserViewModel.currentLocation.value.longitude
            // "lat": 22.8259895,
            // "lng": 89.5510924
          },
        ),
      );

      bool loginError =
      result.data['getOrderOnlinePageSpecialOffersStoresData']['error'];

      if (loginError) {
        Snack.top('Error',
            result.data['getOrderOnlinePageSpecialOffersStoresData']['msg']);
      } else {
        return List<StoreData>.from(result
            .data['getOrderOnlinePageSpecialOffersStoresData']['data']
            .map((type) => StoreData.fromJson(type)));
      }
      return loginError;
    } catch (e) {
      print(e.toString());
      return true;
    }
  }
}
