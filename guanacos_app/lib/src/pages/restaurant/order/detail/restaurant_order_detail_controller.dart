import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/models/order.dart';
import 'package:guanacos_app/src/models/response_api.dart';
import 'package:guanacos_app/src/models/user.dart';
import 'package:guanacos_app/src/providers/orders_provider.dart';
import 'package:guanacos_app/src/providers/user_provider.dart';

class RestaurantOrderDetailController extends GetxController{
  Order order = Order.fromJson(Get.arguments['order']);
  UserProvider userProvider = UserProvider();
  OrdersProvider ordersProvider = OrdersProvider();

  var idDelivery = 0.obs;
  List<User> users = <User>[].obs;

  RestaurantOrderDetailController(){
    order.products?.addAll(Get.arguments['products']);
    getDelivery();
  }

  void updateOrder() async{
    // ignore: unrelated_type_equality_checks
    if(idDelivery.value != ''){
      order.iddelivery = idDelivery.value;
      order.status = 'DESPACHADO';
      ResponseApi responseApi = await ordersProvider.update(order);
      Fluttertoast.showToast(msg: responseApi.message ?? '', toastLength: Toast.LENGTH_LONG);
      if(responseApi.success == true){
        Get.offNamedUntil('/restaurant/home', (route) => false);
      }
    } else{
        Get.snackbar('Aviso', 'Se debe asignar un repartidor.');
    }
  }

  void getDelivery() async{
    var result = await userProvider.getAllByRolName('REPARTIDOR');
    users.clear();
    users.addAll(result);
  }

}