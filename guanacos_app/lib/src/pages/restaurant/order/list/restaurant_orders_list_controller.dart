import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RestaurantOrdersListController extends GetxController {
  void logOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}