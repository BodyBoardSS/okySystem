import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gunanacos_app/src/environment/environment.dart';
import 'package:gunanacos_app/src/models/order.dart';
import 'package:gunanacos_app/src/providers/orders_provider.dart';
import 'package:location/location.dart' as location;
import 'package:socket_io_client/socket_io_client.dart';

class DeliveryOrdersMapController extends GetxController {

  Socket socket = io('${Environment.apiUrl}orders/delivery', <String, dynamic>{
    'transports' : ['websocket'],
    'autoConnect': false
  });

  CameraPosition initialPosition = const CameraPosition(target: LatLng(13.6817911, -89.1922692), zoom: 14);

  Completer<GoogleMapController> mapController = Completer();
  
  Position? position;
  LatLng? addresLatLng;

  Order order = Order.fromJson(Get.arguments['order'] ?? {});
  OrdersProvider ordersProvider = OrdersProvider();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  BitmapDescriptor? deliveryMarker;
  BitmapDescriptor? homeMarker;

  StreamSubscription? positionSubscribe;

  Set<Polyline> polylines = <Polyline>{}.obs;  
  List<LatLng> points = [];

  DeliveryOrdersMapController(){
    checkGPS(); 
    connectAndListen();
  }

  void selectRefPoint(BuildContext context){
    if(addresLatLng != null){
      Map<String, dynamic> data = {
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

  void checkGPS() async{
    deliveryMarker = await createMarkerFromAssets('assets/img/delivery_little.png');
    homeMarker = await createMarkerFromAssets('assets/img/home.png');
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
      saveLocation();
      animateCameraPosition(position?.latitude ?? 13.6817911, position?.longitude ?? -89.1922692);
      addMarker('delivery', position?.latitude ?? 13.6817911, position?.longitude ?? -89.1922692, 'Tú posición', '', deliveryMarker!);
      addMarker('home', order.address?.lat ?? 13.6817911, order.address?.lng ?? -89.1922692, 'Tú posición', '', homeMarker!);

      //LatLng from = LatLng(position!.latitude, position!.longitude);
      //LatLng to = LatLng(order.address?.lat ?? 13.6817911, order.address?.lng ?? -89.1922692);
      //setPolylines(from, to); Activar cuando se tenga una cuenta con servicios de google directions
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 1
      );
      positionSubscribe = Geolocator.getPositionStream(
        locationSettings: locationSettings
      ).listen((Position p) { //Position real time
        // ignore: unused_label
        position:p;
        addMarker('delivery', position?.latitude ?? 13.6817911, position?.longitude ?? -89.1922692, 'Tú posición', '', deliveryMarker!);
        animateCameraPosition(position?.latitude ?? 13.6817911, position?.longitude ?? -89.1922692);
      });
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

  @override
  void onClose() {
    super.onClose();
    socket.disconnect();
    positionSubscribe?.cancel();
  }


  void addMarker(String markerId, double lat, double lng, String title, String content, BitmapDescriptor iconMarker){
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
      markerId: id,
      icon: iconMarker,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: title, snippet: content)
    );

    markers[id] = marker;
    update();
  }

  Future<BitmapDescriptor> createMarkerFromAssets(String path) async {
    ImageConfiguration configuration = const ImageConfiguration();
    BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(configuration, path);

    return descriptor;
  }

  void saveLocation() async{
    if(position != null){
      order.lat = position!.latitude;
      order.lng = position!.longitude;
      await ordersProvider.update(order);
    }
  }

  Future<void> setPolylines(LatLng from, LatLng to) async{
    PointLatLng pointFrom = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointTo = PointLatLng(to.latitude, to.longitude);
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      Environment.apiKeyMaps, 
      pointFrom, 
      pointTo
    );

    for(PointLatLng point in result.points){
      points.add(LatLng(point.latitude, point.longitude));
    }
    Polyline polyline =const Polyline(
      polylineId: PolylineId('poly'),
      color: Colors.amber,
      width: 5
    );
    polylines.add(polyline);
    update();
  }

  void centerPosition(){
    if(position != null) {
      animateCameraPosition(position!.latitude, position!.longitude);
    }
  }

  void callNumber() async{
    String number = order.client?.phone ?? '';
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  void connectAndListen(){
    socket.connect();
    socket.onConnect((data){
        print('Este dispositivo se conecto a SocketIO');
    });
  }
}
