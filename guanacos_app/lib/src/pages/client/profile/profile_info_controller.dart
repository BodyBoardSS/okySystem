import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guanacos_app/src/models/user.dart';

class ProfileInfoController extends GetxController{
  var user = User.fromJson(GetStorage().read('user') ?? {}).obs;

  var options = ['Perfil','Salir'];

  ProfileInfoController(){
     // ignore: prefer_is_empty
     if( user.value.roles!.isNotEmpty && user.value.roles!.length >= 1) {
      options.add('Roles');
    }
  }

  void goToUpdatePage() {
    Get.toNamed('/client/profile/update');
  }

  void goToRoles() {
    Get.offNamedUntil('/roles', (route) => false);
  }
}