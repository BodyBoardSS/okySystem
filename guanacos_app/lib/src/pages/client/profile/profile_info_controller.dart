import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/User.dart';

class ProfileInfoController extends GetxController{
  User user = User.fromJson(GetStorage().read('user') ?? {});

  void goToUpdatePage() {
    Get.toNamed('/client/profile/update');
  }
}