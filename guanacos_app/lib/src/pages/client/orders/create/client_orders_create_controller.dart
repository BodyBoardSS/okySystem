import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/product.dart';

class ClientOrdersCreateController extends GetxController{

  List<Product> lstProducts = <Product>[].obs;
  var total = 0.0.obs;

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
      total.value = total.value + (product.quantity! * product.price!);
    }
  }

  void addItem(Product product){
    int index = lstProducts.indexWhere((p) => p.id == product.id);
    lstProducts.remove(product);
    product.quantity = product.quantity!+1;
    lstProducts.insert(index, product);
    GetStorage().write('shoppinBag', lstProducts);
    getTotal();
  }

  void removeItem(Product product){
    if(product.quantity! > 1){
      int index = lstProducts.indexWhere((p) => p.id == product.id);
      lstProducts.remove(product);
      product.quantity = product.quantity!-1;
      lstProducts.insert(index, product);
      GetStorage().write('shoppinBag', lstProducts);
      getTotal();
    }
  }

  void deleteItem(Product product){
    lstProducts.remove(product);
    GetStorage().write('shoppinBag', lstProducts);
    getTotal();
  }

  void goToAddressList(){
    if(lstProducts.isNotEmpty){
      Get.toNamed('/client/address/list');
    }else{
      Fluttertoast.showToast(msg: '¡Debe agregar productos a la lista!', toastLength: Toast.LENGTH_LONG);
    }
  }

}