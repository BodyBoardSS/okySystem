import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guanacos_app/src/models/order.dart';
import 'package:guanacos_app/src/models/product.dart';
import 'package:guanacos_app/src/models/response_api.dart';
import 'package:guanacos_app/src/models/user.dart';
import 'package:guanacos_app/src/models/address.dart' as address;
import 'package:guanacos_app/src/providers/orders_provider.dart';

import 'package:http/http.dart' as http;


class  ClientPaymentsCreateController extends GetConnect{

  Map<String, dynamic>? paymentIntentData;
  OrdersProvider ordersProvider = OrdersProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<void> makePayment(BuildContext context,String amount, String currency) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Guanacos'
        )
      ).then((value){

      });

      // ignore: use_build_context_synchronously
      showPaymentSheet(context);
    } catch (e) {
      if (kDebugMode) {
        print('Error $e');
      }
    }
  }

  showPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value){
        Get.snackbar('Transacción', 'Su pago fue procesado correctamente');
        paymentIntentData = null;
        createOrder();
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('Error con la transaccion: $error - $stackTrace');
        }
      });
    } on StripeException catch (e) {
      showDialog(context: context, builder: (value) => const AlertDialog(
        content: Text('Operacion cancelada'),
      ));
    }
  }

  createPaymentIntent(String amount, String currency) async{
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]':'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer sk_test_51M5IVfANC3nFG82AeF3zpKtJ4HVlJ719RUACmn1SE0Lq5mLshs6bGIIah9zlyEsELEqN8vGQH2DdMPvVOkbjzUDV005X3oeWhO'
          ,'Content-Type': 'application/x-www-form-urlencoded'
        }
      );

      return jsonDecode(response.body);

    } catch (e) {
      if (kDebugMode) {
        print('Error $e');
      }
    }
  }

  void createOrder() async {
    address.Address a = GetStorage().read('address') is address.Address
        ? GetStorage().read('address')
        : address.Address.fromJson(GetStorage().read('address') ?? {});
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
      Get.offNamedUntil('/client/home', (route) => false);
    }
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  String calculateAmount(String amount){
    final a = (double.parse(amount) * 100).toInt();
    return a.toString();
  }
}