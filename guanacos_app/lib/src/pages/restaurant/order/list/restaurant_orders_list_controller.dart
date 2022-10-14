import 'package:get/get.dart';
import 'package:guanacos_app/src/models/order.dart';
import 'package:guanacos_app/src/providers/orders_provider.dart';

class RestaurantOrdersListController extends GetxController {
  
  OrdersProvider ordersProvider = OrdersProvider();
  List<String> status = <String>['PAGADO','DESPACHADO','EN CAMINO', 'ENTREGADO'].obs;

  Future<List<Order>> getOrders(String status) async{
    return ordersProvider.findByStatus(status);
  }

  void goToOrderDetail(Order order){
    Get.toNamed('/restaurant/order/detail', arguments: {
      'order':order.toJson(),
      'products':order.products
    });
  }
}