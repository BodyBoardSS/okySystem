import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:gunanacos_app/src/models/user.dart';
import 'package:gunanacos_app/src/pages/client/address/create/client_address_create_page.dart';
import 'package:gunanacos_app/src/pages/client/address/list/client_address_list_page.dart';
import 'package:gunanacos_app/src/pages/client/home/client_home_page.dart';
import 'package:gunanacos_app/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:gunanacos_app/src/pages/client/orders/detail/client_order_detail_page.dart';
import 'package:gunanacos_app/src/pages/client/orders/map/client_orders_map_page.dart';
import 'package:gunanacos_app/src/pages/client/payments/create/client_payments_create.dart';

import 'package:gunanacos_app/src/pages/client/products/list/client_products_list_page.dart';
import 'package:gunanacos_app/src/pages/client/profile/profile_info_page.dart';
import 'package:gunanacos_app/src/pages/delivery/home/delivery_home_page.dart';
import 'package:gunanacos_app/src/pages/delivery/orders/detail/delivery_order_detail_page.dart';
import 'package:gunanacos_app/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:gunanacos_app/src/pages/delivery/orders/map/delivery_orders_map_page.dart';
import 'package:gunanacos_app/src/pages/home/home_page.dart';
import 'package:gunanacos_app/src/pages/login/login_page.dart';
import 'package:gunanacos_app/src/pages/client/profile/profile_info_update_page.dart';
import 'package:gunanacos_app/src/pages/register/register_page.dart';
import 'package:gunanacos_app/src/pages/restaurant/categories/create/category_create_page.dart';
import 'package:gunanacos_app/src/pages/restaurant/home/restaurant_home_page.dart';
import 'package:gunanacos_app/src/pages/restaurant/order/detail/restaurant_order_detail_page.dart';
import 'package:gunanacos_app/src/pages/restaurant/order/list/restaurant_orders_list_page.dart';
import 'package:gunanacos_app/src/pages/roles/roles_page.dart';

User uSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return GetMaterialApp(
      title: 'GuanacosApp',
      debugShowCheckedModeBanner:false,
      initialRoute: uSession.id != null ? uSession.roles!.length > 1 ? '/roles':'/client/home':'/',
      getPages: [
          GetPage(name: '/', page: () => LoginPage()),
          GetPage(name: '/register', page: () => const RegisterPage()),
          GetPage(name: '/home', page: () => HomePage()),
          GetPage(name: '/roles', page: () => RolesPage()),
          GetPage(name: '/restaurant/order/list', page: () => RestaurantOrdersListPage()),
          GetPage(name: '/restaurant/order/detail', page: () => RestaurantOrderDetailPage()),
          GetPage(name: '/client/home', page: () => ClientHomePage()),
          GetPage(name: '/client/products/list', page: () => ClientProductsListPage()),
          GetPage(name: '/client/products/info', page: () => ProfileInfoPage()),
          GetPage(name: '/client/profile/update', page: () => ProfileUpdatePage()),
          GetPage(name: '/client/orders/create', page: () => ClientOrdersCreatePage()),
          GetPage(name: '/client/orders/detail', page: () => ClientOrderDetailPage()),
          GetPage(name: '/client/orders/map', page: () => ClientOrdersMapPage()),
          GetPage(name: '/client/address/create', page: () => const ClientAddressCreatePage()),
          GetPage(name: '/client/address/list', page: () => ClientAddressListPage()),
          GetPage(name: '/client/payments/create', page: () => const ClientPaymentsCreate()),
          GetPage(name: '/restaurant/home', page: () => RestaurantHomePage()),
          GetPage(name: '/restaurant/category/create', page: () => const CategoryCreatePage()),
          GetPage(name: '/delivery/home', page: () => DeliveryHomePage()),
          GetPage(name: '/delivery/orders/list', page: () => DeliveryOrdersListPage()),
          GetPage(name: '/delivery/order/detail', page: () => DeliveryOrderDetailPage()),
          GetPage(name: '/delivery/orders/map', page: () =>DeliveryOrdersMapPage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xffA47E3B),
          onPrimary: Colors.grey,
          secondary: Colors.amberAccent,
          onSecondary: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
          background: Color(0xff61481C),
          onBackground: Color(0xff61481C),
          surface: Colors.grey,
          onSurface: Colors.grey
        )
      ),
      navigatorKey: Get.key,
    );
  }
}
