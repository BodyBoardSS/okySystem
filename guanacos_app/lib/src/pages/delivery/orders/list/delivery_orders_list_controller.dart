import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/order.dart';
import 'package:gunanacos_app/src/models/user.dart';
import 'package:gunanacos_app/src/providers/orders_provider.dart';

class DeliveryOrdersListController extends GetxController {
  
  OrdersProvider ordersProvider = OrdersProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});
  List<String> status = <String>['DESPACHADO','EN CAMINO', 'ENTREGADO'].obs;

  Future<List<Order>> getOrders(String status) async{
    return ordersProvider.findByUserAndStatus(status,user.id ?? 0);
  }

  void goToOrderDetail(Order order){
    Get.toNamed('/delivery/order/detail', arguments: {
      'order':order.toJson(),
      'products':order.products
    });
  }
}