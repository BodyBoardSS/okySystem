import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/Rol.dart';
import 'package:gunanacos_app/src/models/User.dart';

class RolesController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});

  void goToPageRole(Rol rol){
    Get.offNamedUntil(rol.route ?? '', (route) => false);
  }
}