import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController{
  void logOut(){
    GetStorage().remove('shoppinBag');
    GetStorage().remove('address');
    GetStorage().remove('products');
    GetStorage().remove('user');
    GetStorage().remove('paymenMethod');
    Get.offNamedUntil('/', (route) => false);
  }
}