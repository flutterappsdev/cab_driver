import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

UserCredential currentUser;

final CameraPosition kGooglePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

String mapKey = "AIzaSyBeGGR_m6OI1M9DSuPWq39cAmLpGtSZ4Vo";