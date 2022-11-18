import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/pages/client/payments/list/client_payments_list_controller.dart';

// ignore: must_be_immutable
class ClientPaymentsListPage extends StatelessWidget {
  ClientPaymentsListPage({Key? key}) : super(key: key);

  ClientPaymentsListController con = Get.put(ClientPaymentsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buttonNext(context),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title:const Text(
          'Formas de pago',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: GetBuilder<ClientPaymentsListController>(builder: (value) => Stack(
        children: [
          _textSelectPayment(),
          _radioGroup()
        ],
        ),
      ) 
    );
  }

  Widget _textSelectPayment(){
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 30),
      child: const Text(
        'Elije como pagar tu pedido',
        style: TextStyle(
          color: Colors.black,
          fontSize: 19,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _radioGroup(){
    return Container(
      margin:  const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          _radioSelectorPayment("Efectivo", 0),
          Divider(color: Colors.grey[400],),
          _radioSelectorPayment("Tarjeta", 1),
          Divider(color: Colors.grey[400],),
        ],
      )
    );
  }

  Widget _buttonNext(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.goToPayOrCreate(context),
          style: ElevatedButton.styleFrom(
              padding:const EdgeInsets.symmetric(vertical: 15)),
          child:const Text(
            'Continuar',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          )),
    );
  }

  
  Widget _radioSelectorPayment(String payMethod, int index){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:20),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: index, 
                groupValue: con.radioValue.value, 
                onChanged: con.handleRadioValueChange
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    payMethod,
                    style:const  TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}