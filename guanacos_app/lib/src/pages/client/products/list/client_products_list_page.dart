import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gunanacos_app/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:gunanacos_app/src/pages/client/profile/profile_info_page.dart';
import 'package:gunanacos_app/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:gunanacos_app/src/pages/restaurant/order/list/restaurant_orders_list_page.dart';
import 'package:gunanacos_app/src/widgets/custom_animated_bottom_bar.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController clientController = Get.put(ClientProductsListController());

  final screens = [
    RestaurantOrdersListPage(),
    DeliveryOrdersListPage(),
    ProfileInfoPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          IndexedStack(
            index: clientController.indexTab.value,
            children: screens,
          )
      ),
      bottomNavigationBar: _bottonBar(),
    );
  }

  Widget _bottonBar(){
    return Obx(() => CustomAnimatedBottomBar(
        containerHeight: 70,
        backgroundColor:  Color(0xffA47E3B),
        showElevation: true,
        curve: Curves.easeIn,
        selectedIndex: clientController.indexTab.value,
        onItemSelected: (index) => clientController.changeTab(index),
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Inicio'),
              activeColor: Colors.white,
              inactiveColor: Colors.amber
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.list),
              title: Text('Pedidos'),
              activeColor: Colors.white,
              inactiveColor: Colors.amber
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
              activeColor: Colors.white,
              inactiveColor: Colors.amber
          )

        ],
    ));
  }
}
