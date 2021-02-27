import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:seeya/features/authentication/repository/maprepo.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/util/customButton.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/models/addressModel.dart';
import 'package:seeya/home.dart';

import 'widgets/waitingForMapLoadingWIdget.dart';


class LocationPickerScreen extends StatefulWidget {
  static const double defaultZoom = 20;
  static const double defaultTilt = 1;
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _textEditingController = TextEditingController();

  bool loading = true;

  CameraPosition initialCameraPosition;
  Set<Marker> gMarker = Set<Marker>();

  addMarker(LatLng latLng) async{
    gMarker.add(Marker(
      markerId: MarkerId('gMarker'),
      position: latLng,
    ));
    await getAddressFromLatLng(latLng);
  }

  getAddressFromLatLng(LatLng latLng) async {
    Address address = await MapRepo.getAddressFromLatLng(latLng);
    _textEditingController.text = address.addressLine;
  }

  _updateCameraPosition(LatLng loc) async {
    CameraPosition cPosition = CameraPosition(
      zoom: LocationPickerScreen.defaultZoom,
      tilt: LocationPickerScreen.defaultTilt,
      target: LatLng(loc.latitude, loc.longitude),
    );
    GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }

  getData() async{
    Position position = await MapRepo.getCurrentLocation();
    initialCameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: LocationPickerScreen.defaultZoom,
    );
    await addMarker(LatLng(position.latitude, position.longitude));
    setState(() {
      loading = false;
    });
  }

  setNewLocation(LatLng latLng) async{
    await addMarker(latLng);
    await _updateCameraPosition(latLng);
    setState(() {});
  }

  searchFromTxtField(value) async{
    Address address = await MapRepo.getAddressFromAddress(value);
    setState(() {
      addMarker(LatLng(address.coordinates.latitude, address.coordinates.longitude));
      _textEditingController.text = address.addressLine;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Card(
          shape: CircleBorder(),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: AppConst.blue,
            ),
          ),
        ),
        title: Card(
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                prefixIcon: Icon(
                  CupertinoIcons.location_solid,
                  color: AppConst.blue,
                )
            ),
          ),
        ),
        titleSpacing: 0,
      ),
      body: loading ? WaitingMapWidget() : Stack(
        children: [
          GoogleMap(
            markers: gMarker,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            compassEnabled: false,
            initialCameraPosition: initialCameraPosition,
            onTap: setNewLocation,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: CustomButton(
              function: (){
                Get.back(result: _textEditingController.text);
                Get.offAll(()=> Home());
              },
              title: 'Choose location',
            ),
          )
        ],
      ),
    );
  }
}

class AddressListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Address'
        ),
      ),
      body: ListView.builder(
        itemCount: UserViewModel.user.value.addresses.length,
        shrinkWrap: true,
        itemBuilder: (_ ,index) {
          AddressModel address = UserViewModel.user.value.addresses[index];
          return ListTile(
            onTap: () => Get.offAll(()=> Home()),
            title: Text(
              address.address
            ),
          );
        },
      ),
      floatingActionButton: CustomButton(
        function: (){
          Get.to(()=> LocationPickerScreen());
        },
        title: 'Add new Address',
      ),
    );
  }
}
