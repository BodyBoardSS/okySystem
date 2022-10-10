import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/environment/environment.dart';
import 'package:gunanacos_app/src/models/product.dart';
import 'package:gunanacos_app/src/models/user.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class ProductsProvider extends GetConnect{

  User user = User.fromJson(GetStorage().read('user') ?? {});

  String url = "${Environment.apiUrl}api";

  Future<Stream> create(Product product, List<File> images) async{
    Uri uri = Uri.https(Environment.apiUrlOld, '/api/products');

    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = user.sessionToken ?? '';

    for (int i = 0; i < images.length; i++){
      request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(images[i].openRead().cast()),
        await images[i].length(),
        filename: p.basename(images[i].path)
      ));
    }

    

    request.fields['product'] = json.encode(product);

    final response = await request.send();

    return response.stream.transform(utf8.decoder);
  }

   Future<List<Product>> findByCategory(int idCategorysync) async {
    Response response = await get(
      '$url/products/$idCategorysync',
      headers: {
        'Content-Type' : 'application/json',
        'Authorization' : user.sessionToken ?? ''
      }
    );

     if(response.statusCode == 500 || response.statusCode == null) {
      Get.snackbar("Error", "Lo sentimos estamos teniendo algunos problemas.");
      return [];
    }

    if(response.statusCode == 401){
      Get.snackbar('Petición denegada', 'Privilegios insuficientes');
      return [];
    }

    List<Product> products = Product.fromJsonList(response.body);

    return products;
  }

   Future<List<Product>> findByCategoryAndName(int idCategory, String name) async {
    Response response = await get(
      '$url/products/$idCategory/$name',
      headers: {
        'Content-Type' : 'application/json',
        'Authorization' : user.sessionToken ?? ''
      }
    );

     if(response.statusCode == 500 || response.statusCode == null) {
      Get.snackbar("Error", "Lo sentimos estamos teniendo algunos problemas.");
      return [];
    }

    if(response.statusCode == 401){
      Get.snackbar('Petición denegada', 'Privilegios insuficientes');
      return [];
    }

    List<Product> products = Product.fromJsonList(response.body);

    return products;
  }
}