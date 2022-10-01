import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/product.dart';


class ClientProductsDetailController extends GetxController {

  

  List<Product> lstProducts = [];

  ClientProductsDetailController();

  void checkProductsAdded(Product product, var price, var counter){
    price.value = product.price ?? 0.0;
    if(GetStorage().read('shoppinBag') != null) {
      if(GetStorage().read('shoppinBag') is List<Product>) {
        lstProducts = GetStorage().read('shoppinBag');
      } else {
        lstProducts = Product.fromJsonList(GetStorage().read('shoppinBag'));
      }

      int index = lstProducts.indexWhere((p) => p.id == product.id);
      if(index != -1){
        counter.value = lstProducts[index].quantity ?? 0;
        price.value = product.price! * counter.value;
      }
    }
  }

  void addItem(Product product, var price, var counter){
    counter.value = counter.value + 1;
    price.value = product.price! * counter.value;
  }

  void removeItem(Product product, var price, var counter){
    if(counter.value > 0){
      counter.value = counter.value - 1;
      price.value = product.price! * counter.value;
    }
  }

  void addToBag(Product product, var price, var counter){
    if(counter.value > 0){
      int index = lstProducts.indexWhere((p) => p.id == product.id);

    if(index == -1){
      if(product.quantity == null){
        if(counter.value > 0) {
          product.quantity = counter.value;
        } else {
          product.quantity = 1;
        }
        
        lstProducts.add(product);
      }
    }else{
        lstProducts[index].quantity = counter.value;
    }

    GetStorage().write('shoppinBag', lstProducts);

    Fluttertoast.showToast(msg: 'Producto agregado');
    } else{
      Fluttertoast.showToast(msg: 'Se debe seleccionar al menus un item para agregar.');
    }
  }

}