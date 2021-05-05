import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:seeya/main_app/config/gqlConfig.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:location/location.dart';

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

  static Future<Position> getCurrentLocation2() async{
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return Position(latitude: _locationData.latitude, longitude: _locationData.longitude);
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



  static Future<bool> addCustomerAddress(String address,String title, double lat, double lng) async{
    final mutationAddCustomerAddress = r'''
  mutation($address : String $title: String $lat: Float $lng: Float){
    addCustomerAddress(address:{
      address: $address
      title: $title
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
    try{

      Map<String, dynamic> variables = {
        'address' : address,
        'title' : title,
        'lat' : lat,
        'lng' : lng
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.mutate(MutationOptions(
        document: gql(mutationAddCustomerAddress),
        variables: variables
      ));

      return result.data['addCustomerAddress']['error'];

    }catch(e){
      print(e.toString());
      return true;
    }
  }

  static Future<bool> deleteCustomerAddress(String addressID) async{
    final mutationAddCustomerAddress = r'''
mutation($id: ID){
  deleteCustomerAddress(_id: $id){
    error
    msg
  }
}
  ''';
    try{

      Map<String, dynamic> variables = {
        'id' : addressID
      };

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.mutate(MutationOptions(
        document: gql(mutationAddCustomerAddress),
        variables: variables
      ));

      return result.data['deleteCustomerAddress']['error'];

    }catch(e){
      print(e.toString());
      return true;
    }
  }
}