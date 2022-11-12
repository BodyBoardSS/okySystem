import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/models/address.dart';
import 'package:guanacos_app/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:guanacos_app/src/widgets/no_data_widget.dart';

// ignore: must_be_immutable
class ClientAddressListPage extends StatelessWidget {
  ClientAddressListPage({Key? key}) : super(key: key);

  ClientAddressListController addressController = Get.put(ClientAddressListController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buttonNext(context),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title:const Text(
          'Mis direcciones',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: [
          _iconAdd()
        ],
      ),
      body: GetBuilder<ClientAddressListController>(builder: (value) => Stack(
        children: [
          _textSelectAddress(),
          _listAddress(context)
        ],
        ),
      ) 
    );
  }

  Widget _iconAdd(){
    return IconButton(
      onPressed: () => addressController.goToAddressCreate(), 
      icon:const Icon(
        Icons.add,
        color: Colors.black,
      )
    );
  }

  Widget _textSelectAddress(){
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 30),
      child: const Text(
        'Elije donde recibir tu pedido',
        style: TextStyle(
          color: Colors.black,
          fontSize: 19,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _listAddress(BuildContext context){
    return Container(
      margin:  const EdgeInsets.only(top: 50),
      child: FutureBuilder(
        future: addressController.getAddress(),
        builder: (context, AsyncSnapshot<List<Address>> snapshot){
          if(snapshot.hasData){
            if(snapshot.data!.isNotEmpty){
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                padding: const EdgeInsets.symmetric(horizontal:10, vertical: 20),
                itemBuilder: (_, index){
                  return _radioSelectorAddress(snapshot.data![index], index);
                }
              );
            } else {
              return Center(
                child: NoDataWidget(
                  text: 'No hay direcciones',
                ),
              );
            }
          } else {
            return Center(
              child: NoDataWidget(
                text: 'No hay direcciones',
              ),
            );
          }
        }
      ),
    );
  }

  Widget _radioSelectorAddress(Address address, int index){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:20),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: index, 
                groupValue: addressController.radioValue.value, 
                onChanged: addressController.handleRadioValueChange
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.address ?? '',
                    style:const  TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    address.neighborhood ?? '',
                    style:const  TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(color: Colors.grey[400],)
        ],
      ),
    );
  }

   Widget _buttonNext(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ElevatedButton(
          onPressed: () => addressController.goToPaymentsCreate(),
          style: ElevatedButton.styleFrom(
              padding:const EdgeInsets.symmetric(vertical: 15)),
          child:const Text(
            'Continuar',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          )),
    );
  }

}