import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guanacos_app/src/models/order.dart';
import 'package:guanacos_app/src/models/user.dart';
import 'package:guanacos_app/src/providers/orders_provider.dart';

class ClientOrdersListController extends GetxController {
  
  OrdersProvider ordersProvider = OrdersProvider();
  User user = User.fromJson(GetStorage().read('user') ?? {});
  List<String> status = <String>['DESPACHADO','EN CAMINO', 'ENTREGADO'].obs;

  Future<List<Order>> getOrders(String status) async{
    return ordersProvider.findByClientAndStatus(status,user.id ?? 0);
  }

  void goToOrderDetail(Order order){
    Get.toNamed('/client/orders/detail', arguments: {
      'order':order.toJson(),
      'products':order.products
    });
  }
}