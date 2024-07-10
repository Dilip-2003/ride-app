import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_app/authentication/singup.dart';
import 'package:ride_app/global/global_variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> mapCompleterController =
      Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  // Position? currentPositonOfUser;

  void updateThemes(GoogleMapController controller) {
    getJsonFileFromThemes('themes/night_theme_style.json')
        .then((value) => setGoogleMapStyle(value, controller));
  }

  Future<String> getJsonFileFromThemes(String stylePath) async {
    ByteData byteData = await rootBundle.load(stylePath);
    var list = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(list);
  }

  setGoogleMapStyle(String stylePath, GoogleMapController controller) {
    // ignore: deprecated_member_use
    controller.setMapStyle(stylePath);
  }

  // getCurrentLocationOfUser() async {
  //   Position positionOfUser = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation);
  //   currentPositonOfUser = positionOfUser;

  //   LatLng positionOfUserInLatLang =
  //       LatLng(currentPositonOfUser!.latitude, currentPositonOfUser!.longitude);
  //   CameraPosition cameraPosition =
  //       CameraPosition(target: positionOfUserInLatLang, zoom: 15);
  //   controllerGoogleMap!
  //       .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: initialGooglePlexCameraPosition,
          mapType: MapType.normal,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController mapController) {
            controllerGoogleMap = mapController;
            updateThemes(controllerGoogleMap!);
            mapCompleterController.complete(controllerGoogleMap);
            // getCurrentLocationOfUser();
          },
        ),
        Positioned(
          bottom: 10,
          left: 120,
          child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ));
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    ));
  }
}
