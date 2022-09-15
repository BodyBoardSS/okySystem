import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gunanacos_app/src/pages/client/products/list/client_products_list_controller.dart';

// ignore: must_be_immutable
class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController clientController = Get.put(ClientProductsListController());

  ClientProductsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Client Product List'),
      )
    );
  }

}
