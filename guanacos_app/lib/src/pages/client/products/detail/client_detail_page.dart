import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/pages/client/products/detail/client_products_detail_controller.dart';

// ignore: must_be_immutable
class ClientProductsDetailPage extends StatelessWidget {
  ClientProductsDetailPage({Key? key}) : super(key: key);

  ClientProductsDetailController clientProductsDetailController = Get.put(ClientProductsDetailController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:  Text('Detalle'),
      ),
    );
  }
}