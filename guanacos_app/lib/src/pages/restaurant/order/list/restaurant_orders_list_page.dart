import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gunanacos_app/src/pages/restaurant/order/list/restaurant_orders_list_controller.dart';
import 'package:gunanacos_app/src/widgets/background_app.dart';

// ignore: must_be_immutable
class RestaurantOrdersListPage extends StatelessWidget {

  RestaurantOrdersListPage({Key? key}) : super(key: key);

  RestaurantOrdersListController restaurantController = Get.put(RestaurantOrdersListController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:const [
          BackgroundApp(),
          Center(child: Text('Restaurant'))
        ] 
      ),
    );
  }
}
