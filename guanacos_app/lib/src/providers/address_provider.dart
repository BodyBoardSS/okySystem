import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/environment/environment.dart';
import 'package:gunanacos_app/src/models/address.dart';
import 'package:gunanacos_app/src/models/response_api.dart';
import 'package:gunanacos_app/src/models/user.dart';

class AddressProvider extends GetConnect{
  String url = "${Environment.apiUrl}api";

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<ResponseApi> create(Address address) async{
    Response response = await post(
      '$url/address',
      address.toJson(),
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

  Future<List<Address>> getAllByUser(int idUser) async {
    Response response = await get(
      '$url/address/$idUser',
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

    List<Address> address = Address.fromJsonList(response.body);

    return address;
  }
}