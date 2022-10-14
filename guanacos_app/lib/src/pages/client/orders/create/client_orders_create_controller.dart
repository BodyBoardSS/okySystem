import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guanacos_app/src/models/product.dart';
import 'package:guanacos_app/src/pages/client/products/list/client_products_list_controller.dart';

class ClientOrdersCreateController extends GetxController{

  List<Product> lstProducts = <Product>[].obs;
  var total = 0.0.obs;

  ClientProductsListController productsListController = Get.find();

  ClientOrdersCreateController(){
    if(GetStorage().read('shoppinBag') != null) {
      if(GetStorage().read('shoppinBag') is List<Product>) {
        var result = GetStorage().read('shoppinBag');
        lstProducts.clear();
        lstProducts.addAll(result);
      } else {
        if (GetStorage().read('shopping_bag') != null){
         var result = Product.fromJsonList(GetStorage().read('shopping_bag'));
          lstProducts.clear();
          lstProducts.addAll(result);
        }
      }

      getTotal();
    }
  }

  void getTotal(){
    total.value = 0.0;
    for (var product in lstProducts) {
      total.value = roundDouble(total.value + (product.quantity! * product.price!),2);
    }
  }

  void addItem(Product product){
    int index = lstProducts.indexWhere((p) => p.id == product.id);
    lstProducts.remove(product);
    product.quantity = product.quantity!+1;
    lstProducts.insert(index, product);
    GetStorage().write('shoppinBag', lstProducts);
    getTotal();
    modifyNumberBag();
  }

  void removeItem(Product product){
    if(product.quantity! > 1){
      int index = lstProducts.indexWhere((p) => p.id == product.id);
      lstProducts.remove(product);
      product.quantity = product.quantity!-1;
      lstProducts.insert(index, product);
      GetStorage().write('shoppinBag', lstProducts);
      getTotal();
      modifyNumberBag();
    }
  }

  void deleteItem(Product product){
    lstProducts.remove(product);
    GetStorage().write('shoppinBag', lstProducts);
    getTotal();
    if(lstProducts.isEmpty){
      productsListController.items.value = 0;
    }else{
      modifyNumberBag();
    }
  }

  void goToAddressList(){
    if(lstProducts.isNotEmpty){
      Get.toNamed('/client/address/list');
    }else{
      Fluttertoast.showToast(msg: '¡Debe agregar productos a la lista!', toastLength: Toast.LENGTH_LONG);
    }
  }

  void modifyNumberBag(){
    productsListController.items.value = 0;
    for (var p in lstProducts) {
        productsListController.items.value = productsListController.items.value + (p.quantity!);
    }
  }

  double roundDouble(double value, int places){ 
    num mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }
}