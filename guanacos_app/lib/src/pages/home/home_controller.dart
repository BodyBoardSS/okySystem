import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/User.dart';

class HomeController extends GetxController{
  void logOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}