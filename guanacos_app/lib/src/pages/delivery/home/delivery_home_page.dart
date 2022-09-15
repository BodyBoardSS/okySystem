import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gunanacos_app/src/pages/client/profile/profile_info_page.dart';
import 'package:gunanacos_app/src/pages/delivery/home/delivery_home_controller.dart';
import 'package:gunanacos_app/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:gunanacos_app/src/pages/restaurant/order/list/restaurant_orders_list_page.dart';
import 'package:gunanacos_app/src/widgets/custom_animated_bottom_bar.dart';

// ignore: must_be_immutable
class DeliveryHomePage extends StatelessWidget {

  DeliveryHomeController deliveryController = Get.put(DeliveryHomeController());

  final screens = [
    DeliveryOrdersListPage(),
    RestaurantOrdersListPage(),
    ProfileInfoPage()
  ];

  DeliveryHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          IndexedStack(
            index: deliveryController.indexTab.value,
            children: screens,
          )
      ),
      bottomNavigationBar: _bottonBar(),
    );
  }

  Widget _bottonBar(){
    return Obx(() => CustomAnimatedBottomBar(
        containerHeight: 70,
        backgroundColor:  const Color(0xffA47E3B),
        showElevation: true,
        curve: Curves.easeIn,
        selectedIndex: deliveryController.indexTab.value,
        onItemSelected: (index) => deliveryController.changeTab(index),
        items: [
          BottomNavyBarItem(
              icon:const Icon(Icons.apps),
              title: const Text('Inicio'),
              activeColor: Colors.white,
              inactiveColor: Colors.amber
          ),
          BottomNavyBarItem(
              icon:const Icon(Icons.list),
              title:const Text('Pedidos'),
              activeColor: Colors.white,
              inactiveColor: Colors.amber
          ),
          BottomNavyBarItem(
              icon:const Icon(Icons.person),
              title:const Text('Perfil'),
              activeColor: Colors.white,
              inactiveColor: Colors.amber
          )

        ],
    ));
  }
}
