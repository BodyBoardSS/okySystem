import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/pages/delivery/orders/list/delivery_order_list_controller.dart';

class DeliveryOrdersListPage extends StatelessWidget {

  DeliveryOrdersListController deliveryController = Get.put(DeliveryOrdersListController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('DeliveryOrdersListPage'),
    );
  }
}
