import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DeliveryOrdersListController extends GetxController {

  void logOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}