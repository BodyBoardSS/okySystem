import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guanacos_app/src/pages/delivery/orders/map/delivery_orders_map_controller.dart';

// ignore: must_be_immutable
class DeliveryOrdersMapPage extends StatelessWidget {
  DeliveryOrdersMapPage({Key? key}) : super(key: key);

  DeliveryOrdersMapController mapController =
      Get.put(DeliveryOrdersMapController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryOrdersMapController>(
      builder: (value) => Scaffold(
      body: Stack(children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: _googleMaps()),
        SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buttonBack(),
                  _iconCenterMyLocation(),
                ],
              ),
              const Spacer(),
              _cardOrderInfo(context),
            ],
          ),
        )
      ]),
    ));
  }

  Widget _buttonBack() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.amber,
            size: 30,
          )),
    );
  }

  Widget _googleMaps() {
    return GoogleMap(
      initialCameraPosition: mapController.initialPosition,
      mapType: MapType.normal,
      onMapCreated: mapController.onMapCreate,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      markers: Set<Marker>.of(mapController.markers.values),
      //polylines: mapController.polylines, Activar cuando se tenga una cuenta con servicios de google directions
    );
  }

  Widget _cardOrderInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        children: [
          _listTileAddress(mapController.order.address?.neighborhood ?? '',
              'Barrio', Icons.my_location),
          _listTileAddress(mapController.order.address?.address ?? '',
              'Dirección', Icons.my_location),
          const Divider(color: Colors.grey, endIndent: 30, indent: 30),
          _clientInfo(),
          _buttonAccept(context)
        ],
      ),
    );
  }

  Widget _listTileAddress(String title, String subTitle, IconData iconData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 13),
        ),
        subtitle: Text(subTitle),
        trailing: Icon(iconData),
      ),
    );
  }

  Widget _buttonAccept(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: ElevatedButton(
        onPressed: mapController.isClose == true ? () => mapController.updateToDelivered() : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(15),
        ),
        child: const Text(
          'Entregar Pedido',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _clientInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Row(children: [
        _imageClient(),
        const SizedBox(width: 15),
        Text(
          '${mapController.order.client?.name} ${mapController.order.client?.lastName}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Colors.grey[200]),
          child: IconButton(
              onPressed: () => mapController.callNumber(),
              icon: const Icon(
                Icons.phone,
                color: Colors.black,
              )),
        )
      ]),
    );
  }

  Widget _imageClient() {
    return SizedBox(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          placeholder: const AssetImage('assets/img/no-image.png'),
          image: mapController.order.client!.image != null
              ? NetworkImage(mapController.order.client!.image!)
              : const AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
        ),
      ),
    );
  }

  Widget _iconCenterMyLocation() {
    return GestureDetector(
      onTap: () => mapController.centerPosition(),
      child: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: const CircleBorder(),
          color: Colors.amber,
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.location_searching,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
