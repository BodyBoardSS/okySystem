import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/user.dart';
import 'package:gunanacos_app/src/providers/push_notifications_provider.dart';

class DeliveryHomeController extends GetxController{

  PushNotificationsProvider pushNotificationsProvider = PushNotificationsProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});

  DeliveryHomeController(){
    saveToken();
  }
  
  var indexTab = 0.obs;

  void changeTab(int index){
    indexTab.value = index;
  }

  void logOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }

  void saveToken(){
    if(user.id != null){
      pushNotificationsProvider.saveToken(user);
    }
  }
}