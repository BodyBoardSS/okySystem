import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;

class ClientAddressMapController extends GetxController {
  CameraPosition initialPosition =
      const CameraPosition(target: LatLng(13.6817911, -89.1922692), zoom: 14);

  Completer<GoogleMapController> mapController = Completer();
  Position? position;

  LatLng? addresLatLng;

  var addressName = ''.obs;

  ClientAddressMapController(){
    checkGPS(); 
  }

  void selectRefPoint(BuildContext context){
    if(addresLatLng != null){
      Map<String, dynamic> data = {
        'address':addressName.value,
        'lat':addresLatLng!.latitude,
        'lng':addresLatLng!.longitude
      };
      Navigator.pop(context, data);
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  // ignore: prefer_void_to_null
  Future<Null> setLocationDraggableInfo() async{
    double lat = initialPosition.target.latitude;
    double lng = initialPosition.target.longitude;

    List<Placemark> address = await placemarkFromCoordinates(lat, lng);

    if(address.isNotEmpty){
      String direction = address[0].thoroughfare ?? '';
      String street = address[0].subThoroughfare ?? '';
      String city = address[0].locality ?? '';
      String departament = address[0].administrativeArea ?? '';
      //String country = address[0].country ?? '';

      addressName.value = '$direction #$street, $city, $departament';
      addresLatLng = LatLng(lat, lng);
    }
  }

  void checkGPS() async{
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if(isLocationServiceEnabled){
      updateLocation();
    }else{
      bool locationGPS = await location.Location().requestService();
      if(locationGPS){
        updateLocation();
      }
    }
  }

  void updateLocation() async{
    try {
      await _determinePosition();
      position = await Geolocator.getLastKnownPosition();
      animateCameraPosition(position?.latitude ?? 13.6817911, position?.longitude ?? -89.1922692);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future animateCameraPosition(double lat, double lng) async{
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat, lng),
        zoom: 13,
        bearing: 0
      )
    ));
  }

  void onMapCreate(GoogleMapController controller) {
    mapController.complete(controller);
  }
}
