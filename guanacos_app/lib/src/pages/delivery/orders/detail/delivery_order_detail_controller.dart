import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/order.dart';
import 'package:gunanacos_app/src/models/response_api.dart';
import 'package:gunanacos_app/src/models/user.dart';
import 'package:gunanacos_app/src/providers/orders_provider.dart';
import 'package:gunanacos_app/src/providers/user_provider.dart';

class DeliveryOrderDetailController extends GetxController{
  Order order = Order.fromJson(Get.arguments['order']);
  UserProvider userProvider = UserProvider();
  OrdersProvider ordersProvider = OrdersProvider();

  var idDelivery = 0.obs;
  List<User> users = <User>[].obs;

  DeliveryOrderDetailController(){
    order.products?.addAll(Get.arguments['products']);
  }

  void updateOrder() async{
    order.status = 'EN CAMINO';
    ResponseApi responseApi = await ordersProvider.update(order);
    Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
    if(responseApi.success == true){
      Get.toNamed('/delivery/orders/map', arguments: {
        'order':order.toJson()
      });
    }
  }

  void goToOrderMap(){
    Get.toNamed('/delivery/orders/map', arguments: {
        'order':order.toJson()
      });
  }
}