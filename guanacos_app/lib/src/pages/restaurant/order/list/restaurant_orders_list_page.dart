import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gunanacos_app/src/pages/restaurant/order/list/restaurant_orders_list_controller.dart';

class RestaurantOrdersListPage extends StatelessWidget {
  RestaurantOrdersListController restaurantController = Get.put(RestaurantOrdersListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('RestaurantOrdersListPage'),
    );
  }
}
