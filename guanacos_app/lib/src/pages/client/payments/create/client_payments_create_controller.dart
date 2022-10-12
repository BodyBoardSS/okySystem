import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/address.dart';
import 'package:gunanacos_app/src/models/order.dart';
import 'package:gunanacos_app/src/models/product.dart';
import 'package:gunanacos_app/src/models/response_api.dart';
import 'package:gunanacos_app/src/models/user.dart';
import 'package:gunanacos_app/src/providers/orders_provider.dart';

class ClientPaymentsCreateController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});
  
  OrdersProvider ordersProvider = OrdersProvider();

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
      Get.toNamed('/client/home');
      update();
    }
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
