import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/user.dart';
import 'package:gunanacos_app/src/providers/push_notifications_provider.dart';

class ClientHomeController extends GetxController{

  PushNotificationsProvider pushNotificationsProvider = PushNotificationsProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  var indexTab = 0.obs;

  ClientHomeController(){
    saveToken();
  }

  void changeTab(int index){
    indexTab.value = index;
  }

  void logOut() {
    GetStorage().remove('shoppinBag');
    GetStorage().remove('address');
    GetStorage().remove('products');
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }

  void saveToken(){
    if(user.id != null){
      pushNotificationsProvider.saveToken(user);
    }
  }
}