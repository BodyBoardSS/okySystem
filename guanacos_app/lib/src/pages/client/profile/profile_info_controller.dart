import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/user.dart';

class ProfileInfoController extends GetxController{
  var user = User.fromJson(GetStorage().read('user') ?? {}).obs;

  void goToUpdatePage() {
    Get.toNamed('/client/profile/update');
  }
}