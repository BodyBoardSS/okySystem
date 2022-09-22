import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gunanacos_app/src/pages/client/profile/profile_info_page.dart';
import 'package:gunanacos_app/src/pages/restaurant/categories/create/category_create_page.dart';
import 'package:gunanacos_app/src/pages/restaurant/home/restaurant_home_controller.dart';
import 'package:gunanacos_app/src/pages/restaurant/order/list/restaurant_orders_list_page.dart';
import 'package:gunanacos_app/src/pages/restaurant/products/create/product_create_page.dart';
import 'package:gunanacos_app/src/widgets/custom_animated_bottom_bar.dart';

// ignore: must_be_immutable
class RestaurantHomePage extends StatelessWidget {

  RestaurantHomeController restaurantController = Get.put(RestaurantHomeController());

  final screens = [
    RestaurantOrdersListPage(),
    const CategoryCreatePage(),
    const ProductCreatePage(),
    ProfileInfoPage()
  ];

  RestaurantHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          IndexedStack(
            index: restaurantController.indexTab.value,
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
        selectedIndex: restaurantController.indexTab.value,
        onItemSelected: (index) => restaurantController.changeTab(index),
        items: [
          BottomNavyBarItem(
              icon:const Icon(Icons.apps),
              title: const Text('Pedidos'),
              activeColor: Colors.white,
              inactiveColor: Colors.amber
          ),
           BottomNavyBarItem(
              icon:const Icon(Icons.category),
              title:const Text('Categorias'),
              activeColor: Colors.white,
              inactiveColor: Colors.amber
          ),
          BottomNavyBarItem(
              icon:const Icon(Icons.restaurant),
              title:const Text('Productos'),
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
