import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gunanacos_app/src/pages/client/products/list/client_products_list_controller.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsListController clientController = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('ClientProductsListPage'),
    );
  }
}
