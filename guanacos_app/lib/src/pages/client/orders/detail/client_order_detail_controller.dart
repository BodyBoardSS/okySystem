
import 'package:get/get.dart';
import 'package:guanacos_app/src/models/order.dart';
import 'package:guanacos_app/src/models/user.dart';
import 'package:guanacos_app/src/providers/orders_provider.dart';
import 'package:guanacos_app/src/providers/user_provider.dart';

class ClientOrderDetailController extends GetxController{
  Order order = Order.fromJson(Get.arguments['order']);
  UserProvider userProvider = UserProvider();
  OrdersProvider ordersProvider = OrdersProvider();

  var idDelivery = 0.obs;
  List<User> users = <User>[].obs;

  ClientOrderDetailController(){
    update();
    order.products?.addAll(Get.arguments['products']);
  }

  void goToOrderMap(){
    Get.toNamed('/client/orders/map', arguments: {
        'order':order.toJson()
      });
  }
}