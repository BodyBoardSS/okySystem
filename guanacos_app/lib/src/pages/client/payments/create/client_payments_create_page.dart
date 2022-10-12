import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/pages/client/payments/create/client_payments_create_controller.dart';

// ignore: must_be_immutable
class ClientPaymentsCreatePage extends StatelessWidget {
  ClientPaymentsCreatePage({Key? key}) : super(key: key);
  ClientPaymentsCreateController paymentController = Get.put(ClientPaymentsCreateController());

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
        )
      ),
      body: const Center(
        child: Text('Pagos'),
      ),
    );
  }

  Widget _buttonNext(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ElevatedButton(
          onPressed: () => paymentController.createOrder(),
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