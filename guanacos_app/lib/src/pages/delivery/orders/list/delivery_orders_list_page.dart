import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/pages/delivery/orders/list/delivery_order_list_controller.dart';
import 'package:gunanacos_app/src/pages/home/home_controller.dart';

class DeliveryOrdersListPage extends StatelessWidget {

  DeliveryOrdersListController deliveryController = Get.put(DeliveryOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Delivery'),),
      body: Center(
        child: ElevatedButton(
          onPressed: ()=> deliveryController.logOut(),
          child: Text('Salir'),
        ),
      ),
    );
  }
}
