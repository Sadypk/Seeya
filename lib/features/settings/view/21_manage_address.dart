import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seeya/features/authentication/view/location_picker_screen.dart';
import 'package:seeya/features/home_screen/view/all_offers_near_you.dart';
import 'package:seeya/home.dart';
import 'package:seeya/main_app/config/localStorage.dart';
import 'package:seeya/main_app/models/addressModel.dart';
import 'package:seeya/main_app/resources/app_const.dart';
import 'package:seeya/main_app/user/viewModel/userViewModel.dart';
import 'package:seeya/main_app/util/screenLoader.dart';
import 'package:seeya/main_app/view/widgets/gradient_button.dart';
import 'package:seeya/newMainAPIs.dart';

class ManageAddressScreen extends StatefulWidget {
  final bool switchLocation;

  ManageAddressScreen({this.switchLocation = false});

  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  bool loading = false;

  loadScreen() => setState(() => loading = !loading);

  @override
  Widget build(BuildContext context) {


    return IsScreenLoading(
      screenLoading: loading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Manage address',
            style: AppConst.appbarTextStyle,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Saved address',
                    style: AppConst.titleText1,
                  )),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: UserViewModel.user.value.addresses.length,
                      itemBuilder: (BuildContext context, int index) {

                        var data = UserViewModel.user.value.addresses[index];
                        return GestureDetector(
                          onTap: () async {
                            UserViewModel.setLocationIndex(index);
                            if (widget.switchLocation) {
                              Get.back(result: true);
                            } else {
                              UserViewModel.setLocation(
                                  LatLng(data.location.lat, data.location.lng));
                              if (LocalStorage.checkFirstTime()) {
                                Get.offAll(() => AllOffersNearYou());
                              } else {
                                if (await NewApi.getHomeFavShops() == 0) {
                                  Get.offAll(() => AllOffersNearYou());
                                } else {
                                  Get.offAll(() => Home());
                                }
                              }
                            }
                          },
                          child: Container(
                            height: 122,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200, width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 12),
                                      blurRadius: 12,
                                      color: Colors.grey.shade200)
                                ],
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  FeatherIcons.mapPin,
                                  color: AppConst.themePurple,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${data.title.trim().capitalize}',
                                          style: AppConst.titleText1_2),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        '${data.address.trim().capitalize}',
                                        style: AppConst.descriptionTextOpen,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Edit',
                                            style: TextStyle(
                                                fontFamily: 'Stag',
                                                fontSize: 14,
                                                decoration: TextDecoration.underline,
                                                color: AppConst.themePurple),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          GestureDetector(
                                              onTap: () async {
                                                /*loadScreen();
                          bool error = await MapRepo.deleteCustomerAddress(address.id);
                          loadScreen();
                          if(!error){
                            setState(() {
                              UserViewModel.user.value.addresses.remove(address);
                            });
                          }*/
                                              },
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    fontFamily: 'Stag',
                                                    fontSize: 14,
                                                    decoration: TextDecoration.underline,
                                                    color: AppConst.themePurple),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: GradientButton(
            onTap: () {
              Get.to(() => LocationPickerScreen());
            },
            height: 50,
            label: 'Add new Address',
            fontStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
