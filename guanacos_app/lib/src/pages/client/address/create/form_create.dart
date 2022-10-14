import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/pages/client/address/create/client_address_create_controller.dart';

// ignore: must_be_immutable
class FormCreate extends StatelessWidget {
  FormCreate({Key? key}) : super(key: key);

  ClientAddressCreateController addressController =  Get.put(ClientAddressCreateController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.30, left: 50, right: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _txtInfo(),
            const SizedBox(height: 10,),
            _txtFieldAddress(),
            const SizedBox(height: 10,),
            _txtFieldNeighborhood(),
            const SizedBox(height: 10,),
            _txtFieldRefPoint(context),
            const SizedBox(height: 10,),
            _buttonCreate(context)
          ],
        ),
      )
    );
  }

   Widget _txtInfo() {
    return Container(
        margin:const EdgeInsets.only(top: 10, bottom: 20),
        child:const Text('Ingrese esta informacion',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)));
  }


  Widget _txtFieldAddress() {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: addressController.addressController,
        keyboardType: TextInputType.text,
        decoration:const InputDecoration(
            hintText: 'Dirección', prefixIcon: Icon(Icons.location_on)),
      ),
    );
  }

  Widget _txtFieldNeighborhood() {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: addressController.neighborhoodController,
        maxLines: 4,
        keyboardType: TextInputType.text,
        decoration:const InputDecoration(
            hintText: 'Vecindario', prefixIcon: Icon(Icons.location_city)),
      ),
    );
  }

  Widget _txtFieldRefPoint(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onTap: () => addressController.openGoogleMaps(context),
        controller: addressController.refPointController,
        autofocus: false,
        focusNode: AlwaysDisableFocusNode(),
        maxLines: 4,
        keyboardType: TextInputType.text,
        decoration:const InputDecoration(
            hintText: 'Punto de referencia', prefixIcon: Icon(Icons.map)),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ElevatedButton(
          onPressed: () {
            addressController.createAddress();
          } ,
          style: ElevatedButton.styleFrom(
              padding:const EdgeInsets.symmetric(vertical: 15)),
          child:const Text(
            'Crear',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          )),
    );
  }
}

class AlwaysDisableFocusNode extends FocusNode{
  @override
  bool get hasFocus => false;
}