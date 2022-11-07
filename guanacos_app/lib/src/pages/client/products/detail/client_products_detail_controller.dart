import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guanacos_app/src/models/product.dart';
import 'package:guanacos_app/src/pages/client/products/list/client_products_list_controller.dart';

class ClientProductsDetailController extends GetxController {
  List<Product> lstProducts = [];

  ClientProductsListController clientProductsListController = Get.find();

  ClientProductsDetailController(){
    if (GetStorage().read('shoppinBag') != null) {
      if (GetStorage().read('shoppinBag') is List<Product>) {
        lstProducts = GetStorage().read('shoppinBag');
      } else {
        lstProducts = Product.fromJsonList(GetStorage().read('shoppinBag'));
      }
    } else {
      update();
    }
  }

  void checkProductsAdded(Product product, var price, var counter) {
    price.value = product.price ?? 0.0;
    if (GetStorage().read('shoppinBag') != null) {
      if (GetStorage().read('shoppinBag') is List<Product>) {
        lstProducts = GetStorage().read('shoppinBag');
      } else {
        lstProducts = Product.fromJsonList(GetStorage().read('shoppinBag'));
      }

      int index = lstProducts.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        counter.value = lstProducts[index].quantity ?? 0;
        price.value = roundDouble((product.price! * counter.value),2);
      }
    } else {
      update();
    }
  }

  void addItem(Product product, var price, var counter) {
    counter.value = counter.value + 1;
    price.value = roundDouble((product.price! * counter.value),2);
  }

  void removeItem(Product product, var price, var counter) {
    if (counter.value > 0) {
      counter.value = counter.value - 1;
      price.value = roundDouble((product.price! * counter.value),2);
    }
  }

  void addToBag(Product product, var price, var counter) {
    if (counter.value > 0) {
      int index = lstProducts.indexWhere((p) => p.id == product.id);

      if (index == -1) {
        if (product.quantity == null) {
          if (counter.value > 0) {
            product.quantity = counter.value;
          } else {
            product.quantity = 1;
          }

          lstProducts.add(product);
        }
      } else {
        lstProducts[index].quantity = counter.value;
      }

      GetStorage().write('shoppinBag', lstProducts);
      modifyNumberBag();
      update();
      Get.offNamedUntil('/client/home', (route) => false);
      Fluttertoast.showToast(msg: 'Producto agregado');
    } else {
      Fluttertoast.showToast(msg: 'Se debe seleccionar al menus un item para agregar.');
    }
  }

  void modifyNumberBag() {
    clientProductsListController.items.value = 0;
    for (var p in lstProducts) {
      clientProductsListController.items.value = clientProductsListController.items.value + (p.quantity!);
    }
  }

  double roundDouble(double value, int places){ 
    num mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }
}
