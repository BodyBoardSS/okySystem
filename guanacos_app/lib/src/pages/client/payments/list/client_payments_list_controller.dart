
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guanacos_app/src/models/address.dart';
import 'package:guanacos_app/src/models/order.dart';
import 'package:guanacos_app/src/models/product.dart';
import 'package:guanacos_app/src/models/response_api.dart';
import 'package:guanacos_app/src/models/user.dart';
import 'package:guanacos_app/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:guanacos_app/src/pages/client/payments/create/client_payments_create_controller.dart';
import 'package:guanacos_app/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:guanacos_app/src/providers/orders_provider.dart';

class ClientPaymentsListController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});

  OrdersProvider ordersProvider = OrdersProvider();
  ClientProductsListController productsListController = Get.find();
  ClientOrdersCreateController clientOrdersCreateController = Get.find();

  ClientPaymentsCreateController paymentController = ClientPaymentsCreateController();

  var radioValue = 0.obs;

  void handleRadioValueChange(int? value) {
    radioValue.value = value!;
    GetStorage().write('paymenMethod', value);
    update();
  }

  void createOrder() async {
    Address a = GetStorage().read('address') is Address
        ? GetStorage().read('address')
        : Address.fromJson(GetStorage().read('address') ?? {});
    List<Product> products = GetStorage().read('shoppinBag');
    double totalC = 0.0;

    for (var product in products) {
      totalC = roundDouble(totalC + (product.quantity! * product.price!), 2);
    }

    Order order = Order(
        idclient: user.id,
        idaddress: a.id,
        status: 'PAGADO',
        total: totalC,
        detail: products);

    ResponseApi responseApi = await ordersProvider.create(order);

    Fluttertoast.showToast(
        msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);

    if (responseApi.success == true) {
      GetStorage().remove('shoppinBag');
      productsListController.items.value = 0;
      productsListController.lstProducts = [];
      clientOrdersCreateController.lstProducts = [];
      Get.offNamedUntil('/client/home', (route) => false);
      update();
    }
  }

  void goToPayOrCreate(BuildContext context) async {
    int? methodPay = GetStorage().read('paymenMethod') ?? 0;
    if (methodPay == 1) {
      List<Product> products = GetStorage().read('shoppinBag');
      double totalC = 0.0;
      for (var product in products) {
        totalC = roundDouble(totalC + (product.quantity! * product.price!), 2);
      }
      await paymentController.makePayment(context,'$totalC', 'USD');
    } else {
      createOrder();
    }
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
