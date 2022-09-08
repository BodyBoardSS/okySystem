import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/User.dart';

class HomeController extends GetxController{
  User user = User.fromJson(GetStorage().read('user') ?? {});

  HomeController(){
    print('Usuarion en session ${user.toJson()}');
  }

  void logOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}