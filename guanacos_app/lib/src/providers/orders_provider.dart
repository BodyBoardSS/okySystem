import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/environment/environment.dart';
import 'package:gunanacos_app/src/models/order.dart';
import 'package:gunanacos_app/src/models/response_api.dart';
import 'package:gunanacos_app/src/models/user.dart';

class OrdersProvider extends GetConnect{
  String url = "${Environment.apiUrl}api";

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<ResponseApi> create(Order order) async{
    Response response = await post(
      '$url/orders',
      order.toJson(),
      headers: {
        'Content-Type' : 'application/json',
        'Authorization' : user.sessionToken ?? ''
      }
    );

    if(response.statusCode == 500) {
      Get.snackbar("Error", "Lo sentimos estamos teniendo algunos problemas.");
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<ResponseApi> update(Order order) async{
    Response response = await put(
      '$url/orders/${order.id}',
      order.toJson(),
      headers: {
        'Content-Type' : 'application/json',
        'Authorization' : user.sessionToken ?? ''
      }
    );

    if(response.statusCode == 500) {
      Get.snackbar("Error", "Lo sentimos estamos teniendo algunos problemas.");
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<List<Order>> findByStatus(String status) async {
    Response response = await get(
      '$url/orders/$status',
      headers: {
        'Content-Type' : 'application/json',
        'Authorization' : user.sessionToken ?? ''
      }
    );

    if(response.statusCode == 500) {
      Get.snackbar("Error", "Lo sentimos estamos teniendo algunos problemas.");
      return [];
    }

    if(response.statusCode == 401){
      Get.snackbar('Petición denegada', 'Privilegios insuficientes');
      return [];
    }
  
    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }

  Future<List<Order>> findByUserAndStatus(String status, int idUser) async {
    Response response = await get(
      '$url/orders/$status/$idUser',
      headers: {
        'Content-Type' : 'application/json',
        'Authorization' : user.sessionToken ?? ''
      }
    );

    if(response.statusCode == 500) {
      Get.snackbar("Error", "Lo sentimos estamos teniendo algunos problemas.");
      return [];
    }

    if(response.statusCode == 401){
      Get.snackbar('Petición denegada', 'Privilegios insuficientes');
      return [];
    }
  
    List<Order> orders = Order.fromJsonList(response.body);

    return orders;
  }
}