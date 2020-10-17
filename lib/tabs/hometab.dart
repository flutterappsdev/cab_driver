import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import '../constants/globalvariables.dart';
import '../constants/branb_colour.dart';
import '../widgets/availablity_button.dart';
import '../constants/globalvariables.dart';
import '../widgets/confirmsheet.dart';
import '../helpers/pushnotificationservice.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GoogleMapController _mapController;
  Completer<GoogleMapController> _controller = Completer();

  LocationData currentLocation;
  LocationData destinationLocation;
  Location location;

  DatabaseReference tripRequest;

  bool isAvailable = false;
  String avialaBilityTittlr = 'GO ONLINE';
  Color avalblityColor = BrandColors.colorOrange;

  @override
  void initState() {
    // TODO: implement initState
    location = Location();
    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;

      LatLng pos = LatLng(currentLocation.latitude, currentLocation.longitude);
      CameraPosition cp = CameraPosition(target: pos, zoom: 14);
      _mapController.animateCamera(CameraUpdate.newCameraPosition(cp));

      String pathToReference = "DriversAvailable";
      //Intializing geoFire
      Geofire.initialize(pathToReference);
      Geofire.setLocation(FirebaseAuth.instance.currentUser.uid,
          currentLocation.latitude, currentLocation.longitude);
      getCurrentDriverInfo();
    });
    super.initState();
  }

  void getCurrentDriverInfo () async {

    //currentFirebaseUser = await FirebaseAuth.instance.currentUser();
    PushNotificationService pushNotificationService = PushNotificationService();

    pushNotificationService.initialize(context);
    pushNotificationService.getToken();
  }

  void setUpPositionLocator() async {
    try {
      currentLocation = await location.getLocation();

      LatLng pos = LatLng(currentLocation.latitude, currentLocation.longitude);
      CameraPosition cp = CameraPosition(target: pos, zoom: 14);
      _mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
      //String address = await HelperMethod.getLatLangAddres(pos, context);
      //print(address);
      //print(Provider.of<AppData>(context).pickUpAddress.placeAddress);
    } catch (e) {
      print("krishna $e");
    }
  }

  void goOnline() {
    try {
      String pathToReference = "DriversAvailable";
      //Intializing geoFire
      Geofire.initialize(pathToReference);

      if (isAvailable) {
        Geofire.setLocation(FirebaseAuth.instance.currentUser.uid,
            currentLocation.latitude, currentLocation.longitude);


      }
      tripRequest = FirebaseDatabase.instance
          .reference()
          .child('drivers/${FirebaseAuth.instance.currentUser.uid}');
      tripRequest.set('wating...');

      tripRequest.onValue.listen((event) {});
    } catch (e) {
      print('krishna $e');
    }
  }

  void goOfline(){
    Geofire.removeLocation(FirebaseAuth.instance.currentUser.uid);
    tripRequest.onDisconnect();
    tripRequest.remove();
    tripRequest = null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(top: 135),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _mapController = controller;
              setUpPositionLocator();
            },
          ),
          Container(
            width: double.infinity,
            height: 135,
            decoration: BoxDecoration(color: BrandColors.colorPrimary),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvailablityButton(
                  tittle: avialaBilityTittlr,
                  color: avalblityColor,
                  onPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => ConfrimSheet(
                              tittle:
                                  (!isAvailable) ? 'GO ONLINE' : 'GO OFFLINE',
                              subTittle: (isAvailable)
                                  ? 'You stop receiveing trip request'
                                  : 'You become available to to receive trip request',
                              onPressed: () {
                                if (!isAvailable) {
                                  goOnline();
                                  Navigator.pop(context);
                                  setState(() {
                                    isAvailable = true;
                                    avialaBilityTittlr = 'GO OFFLINE';
                                    avalblityColor = BrandColors.colorGreen;
                                  });

                                }
                                else{
                                  goOfline();
                                  Navigator.pop(context);
                                  setState(() {
                                    isAvailable = false;
                                    avialaBilityTittlr = 'GO ONLINE';
                                    avalblityColor = BrandColors.colorOrange;
                                  });
                                }
                              },
                            ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
