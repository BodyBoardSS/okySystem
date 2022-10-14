import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guanacos_app/src/environment/environment.dart';
import 'package:guanacos_app/src/models/category.dart';
import 'package:guanacos_app/src/models/response_api.dart';
import 'package:guanacos_app/src/models/user.dart';

class CategoriesProvider extends GetConnect{
  String url = "${Environment.apiUrl}api";

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<ResponseApi> create(Category category) async{
    Response response = await post(
      '$url/categories',
      category.toJson(),
      headers: {
        'Content-Type' : 'application/json',
        'Authorization' : user.sessionToken ?? ''
      }
    );

    if(response.statusCode == null || response.statusCode! >= 500) {
      Get.snackbar("Error", "Lo sentimos estamos teniendo algunos problemas.");
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

  Future<List<Category>> getAll() async {
    Response response = await get(
      '$url/categories',
      headers: {
        'Content-Type' : 'application/json',
        'Authorization' : user.sessionToken ?? ''
      }
    );

    if(response.statusCode == null || response.statusCode! >= 500) {
      Get.snackbar("Error", "Lo sentimos estamos teniendo algunos problemas.");
      return [];
    }

    if(response.statusCode == 401){
      Get.snackbar('Petición denegada', 'Privilegios insuficientes');
      return [];
    }

    List<Category> categories = Category.fromJsonList(response.body);

    return categories;
  }
}