import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/address.dart';
import 'package:gunanacos_app/src/models/order.dart';
import 'package:gunanacos_app/src/models/product.dart';
import 'package:gunanacos_app/src/models/response_api.dart';
import 'package:gunanacos_app/src/models/user.dart';
import 'package:gunanacos_app/src/providers/address_provider.dart';
import 'package:gunanacos_app/src/providers/orders_provider.dart';

class ClientAddressListController extends GetxController{

  AddressProvider addressProvider = AddressProvider();
  OrdersProvider ordersProvider = OrdersProvider();
  List<Address> address = [];

  User user = User.fromJson(GetStorage().read('user') ?? {});

  var radioValue = 0.obs;

  void goToAddressCreate(){
    Get.toNamed('/client/address/create');
  }

  Future<List<Address>> getAddress() async{
    address = await addressProvider.getAllByUser(user.id ?? 0);
    if(GetStorage().read('address') != null && GetStorage().read('address') is List<Address>){
      Address a = GetStorage().read('address');

      int index = address.indexWhere((ad) => ad.id == a.id);

      if(index != -1){
        radioValue.value = index;
      }
    } else {
      GetStorage().write('address', address[0]);
    }


    return address;
  }

  void handleRadioValueChange(int? value){
    radioValue.value = value!;
    GetStorage().write('address', address[value]);
    update();
  }

  void createOrder() async{
    Address a = GetStorage().read('address') is Address? GetStorage().read('address') : Address.fromJson(GetStorage().read('address') ?? {});
    List<Product> products = GetStorage().read('shoppinBag');
    double totalC = 0.0;

    for (var product in products) {
      totalC = roundDouble(totalC + (product.quantity! * product.price!),2);
    }

    Order order = Order(
      idclient: user.id,
      idaddress: a.id,
      status: 'PAGADO',
      total: totalC,
      detail: products
    );

    ResponseApi responseApi = await ordersProvider.create(order);

    Fluttertoast.showToast(msg:  responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);

    if(responseApi.success == true){
      GetStorage().remove('shoppinBag');
      Get.toNamed('/client/payments/create');
    }
  }

  double roundDouble(double value, int places){ 
    num mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }
}