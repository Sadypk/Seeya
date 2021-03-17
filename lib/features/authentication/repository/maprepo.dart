import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';


class MapRepo{


  static Future<Position> getCurrentLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<Address> getAddressFromAddress(String value) async{
    List<Address> temp = await Geocoder.local.findAddressesFromQuery(value);
    Address address = temp[0];
    return address;
  }

  static Future<Address> getAddressFromLatLng(LatLng latLng) async{
    List<Address> temp = await Geocoder.local.findAddressesFromCoordinates(Coordinates(latLng.latitude, latLng.longitude));
    return temp[0];
  }


  static const mutationAddCustomerAddress = r'''
  mutation($address : String $lat: Float $lng: Float){
    addCustomerAddress(address:{
      address: $address
      location:{
        lat: $lat
        lng: $lng
      }
    }){
      error
      msg
    }
  }
  ''';

  static addCustomerAddress(String address, double lat, double lng) async{
    try{

      Map<String, dynamic> variables = {
        'address' : address,
        'lat' : lat,
        'lng' : lng
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.mutate(MutationOptions(
        documentNode: gql(mutationAddCustomerAddress),
        variables: variables
      ));

      return result.data['addCustomerAddress']['error'];

    }catch(e){
      print(e.toString());
      return true;
    }
  }
}