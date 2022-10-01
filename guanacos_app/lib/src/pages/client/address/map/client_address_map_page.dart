import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gunanacos_app/src/pages/client/address/map/client_address_map_controller.dart';

class ClientAddressMapPage extends StatelessWidget {
  ClientAddressMapPage({Key? key}) : super(key: key);

  ClientAddressMapController mapControlle = Get.put(ClientAddressMapController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title:const Text(
          'Ubica tu dirección en el mapa',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Stack(
        children:[
          _googleMaps(),
          _iconMyLocations(),
          _cardAddress(),
          _buttonAccept(context)
        ]
      ),
    ));
  }

  Widget _googleMaps(){
    return GoogleMap(
      initialCameraPosition: mapControlle.initialPosition,
      mapType: MapType.normal,
      onMapCreated: mapControlle.onMapCreate,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      onCameraMove: (position){
        mapControlle.initialPosition = position;
      },
      onCameraIdle: () async {
        await mapControlle.setLocationDraggableInfo();
      },
    );
  }

  Widget _buttonAccept(BuildContext context){
    return Container(
      alignment:Alignment.bottomCenter,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      child: ElevatedButton(
        onPressed: () => mapControlle.selectRefPoint(context),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(15),
        ), 
        child: const Text(
          'Seleccionar este punto',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _cardAddress(){
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            mapControlle.addressName.value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconMyLocations(){
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Center(
        child: Image.asset(
          'assets/img/address.png',
          height: 65,
          width: 65,
        ),
      ),
    );
  }
}