import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
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
import 'package:seeya/main_app/util/screenLoader.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';

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

  LatLng currentPosition;

  addMarker(LatLng latLng) async{
    gMarker.add(Marker(
      markerId: MarkerId('gMarker'),
      position: latLng,
    ));
    await getAddressFromLatLng(latLng);
  }

  getToUserLocation()async{
    var currentLatLng = await Geolocator.getCurrentPosition();
    _updateCameraPosition(LatLng(currentLatLng.latitude, currentLatLng.longitude));
  }

  getAddressFromLatLng(LatLng latLng) async {
    currentPosition = latLng;
    Address address = await MapRepo.getAddressFromLatLng(latLng);
    _textEditingController.text = address.addressLine;
  }

  _updateCameraPosition(LatLng loc) async {
    currentPosition = loc;
    CameraPosition cPosition = CameraPosition(
      zoom: LocationPickerScreen.defaultZoom,
      tilt: LocationPickerScreen.defaultTilt,
      target: LatLng(loc.latitude, loc.longitude),
    );
    GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }

  getData() async{
    Position position = await MapRepo.getCurrentLocation2();
    if(position == null){
      Get.back();
      return ;
    }
    initialCameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: LocationPickerScreen.defaultZoom,
    );
    currentPosition = LatLng(position.latitude, position.longitude);
    await addMarker(LatLng(position.latitude, position.longitude));
    setState(() {
      loading = false;
    });
  }

  setNewLocation(LatLng latLng) async{
    currentPosition = latLng;
    await addMarker(latLng);
    await _updateCameraPosition(latLng);
    setState(() {});
  }

  searchFromTxtField(String value) async{
    Address address = await MapRepo.getAddressFromAddress(value);
    await addMarker(LatLng(address.coordinates.latitude, address.coordinates.longitude));
    await _updateCameraPosition(LatLng(address.coordinates.latitude, address.coordinates.longitude));
    setState(() {
    });
    _textEditingController.text = address.addressLine;
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


  bool screenLoading = false;
  int selected = 100;
  @override
  Widget build(BuildContext context) {
    tagLocationSelectionCard(String label, int index){
      return InkWell(
        onTap: (){
          setState(() {
            selected = index;
            print(selected);
          });
        },
        child: Container(
          height: 30,
          width: 65,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: index!=selected?Color.fromARGB(25, 112, 112, 112):Colors.transparent),
            gradient: index==selected?AppConst.gradient1:null,
            boxShadow: [
              if(index!=selected)BoxShadow(
                color: Color.fromARGB(5, 1, 1, 1),
                offset: Offset(0.5,0.5),
                spreadRadius: 0,
                blurRadius: 0.5
              )
            ]
          ),
          child: Center(
            child: Text(label, style: TextStyle(color: index==selected?Colors.white:Colors.black,),),
          ),
        ),
      );
    }
    return IsScreenLoading(
      screenLoading: screenLoading,
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leading: Card(
        //     shape: CircleBorder(),
        //     child: IconButton(
        //       onPressed: () => Get.back(),
        //       icon: Icon(
        //         CupertinoIcons.arrow_left,
        //         color: AppConst.blue,
        //       ),
        //     ),
        //   ),
        //   title: Card(
        //     child: TextField(
        //       controller: _textEditingController,
        //       onSubmitted: searchFromTxtField,
        //       decoration: InputDecoration(
        //           border: OutlineInputBorder(
        //               borderSide: BorderSide.none
        //           ),
        //           prefixIcon: Icon(
        //             CupertinoIcons.location_solid,
        //             color: AppConst.blue,
        //           )
        //       ),
        //     ),
        //   ),
        //   titleSpacing: 0,
        // ),
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

            //bottom drawer
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      getToUserLocation();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey[300],width: 1),
                        boxShadow: [AppConst.shadowBasic]
                      ),
                      child: Center(
                        child: Icon(Icons.gps_fixed_rounded, color: Colors.grey, size: 18,),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0,1),
                              color: Colors.grey,
                              blurRadius: 1,
                              spreadRadius: 1
                          )
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Delivery Location', style: AppConst.titleText1,),
                        SizedBox(height: 7,),
                        TextFormField(
                          controller: _textEditingController,
                          onFieldSubmitted: searchFromTxtField,
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5, right: 7),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: Icon(FeatherIcons.mapPin, color: Colors.black87, size: 18,),
                            suffixText: 'Change',
                            suffixStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppConst.themePurple, fontFamily: 'Stag', decoration: TextDecoration.underline),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey[300],
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text('Tag this location', style: AppConst.header,),
                        SizedBox(height: 10,),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            tagLocationSelectionCard('Home', 0),
                            tagLocationSelectionCard('Work', 1),
                            tagLocationSelectionCard('Hotel', 2),
                            tagLocationSelectionCard('Offer', 3),
                          ],
                        ),
                        SizedBox(height: 20,),
                        GradientButton(
                          height: 55,
                          label: 'Confirm Location and Proceed',
                          fontStyle: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 0.3, color: Colors.white, fontSize: 14),
                          onTap: (){
                            setNewLocation(currentPosition);
                            Get.offAll(Home());
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )

            // Positioned(
            //   left: 20,
            //   right: 20,
            //   bottom: 20,
            //   child: CustomButton(
            //     height: 55,
            //     function: () async{
            //       setState(() {
            //         screenLoading = true;
            //       });
            //       bool error = await MapRepo.addCustomerAddress(_textEditingController.text, currentPosition.latitude, currentPosition.longitude);
            //
            //       setState(() {
            //         screenLoading = false;
            //       });
            //       if(error){
            //
            //       }else{
            //         UserViewModel.setLocation(currentPosition);
            //         Get.offAll(()=> Home());
            //       }
            //     },
            //     title: 'Choose location',
            //   ),
            // )
          ],
        ),
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
          'Choose Address to continue',
          style: TextStyle(
            color: Colors.red
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: UserViewModel.user.value.addresses.length,
        shrinkWrap: true,
        itemBuilder: (_ ,index) {
          AddressModel address = UserViewModel.user.value.addresses[index];
          return Card(
            elevation: 20,
            child: ListTile(
              onTap: () {
                UserViewModel.setLocation(LatLng(address.location.lat, address.location.lng));
                Get.offAll(()=> Home());
              },
              title: Text(
                address.address
              ),
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
