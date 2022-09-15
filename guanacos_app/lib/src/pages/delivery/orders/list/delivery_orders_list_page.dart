import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/pages/delivery/orders/list/delivery_order_list_controller.dart';
import 'package:gunanacos_app/src/widgets/background_app.dart';

// ignore: must_be_immutable
class DeliveryOrdersListPage extends StatelessWidget {
  DeliveryOrdersListPage({Key? key}) : super(key: key);

  DeliveryOrdersListController deliveryController = Get.put(DeliveryOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:const [
          BackgroundApp(),
          Center(child: Text('Delivery'))
        ] 
      ),
    );
  }
}
