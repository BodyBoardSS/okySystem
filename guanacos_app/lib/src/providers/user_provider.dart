import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:gunanacos_app/src/environment/environment.dart';
import 'package:gunanacos_app/src/models/ResponseAPI.dart';

import '../models/User.dart';

class UserProvider extends GetConnect {
  String url = Environment.API_URL+"api";

  Future<Response> create(User user) async{
    Response response = await post(
      '$url/signUpWithImage',
      user.toJson(),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    return response;
  }

  Future<Stream> createWithImage(User user, File img) async{
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/signUpWithImage');

    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(img.openRead().cast()),
      await img.length(),
      filename: basename(img.path)
    ));

    request.fields['user'] = json.encode(user);

    final response = await request.send();

    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> login(String email, String password) async{
    Response response = await post(
      '$url/signin',
        {
          'email':email,
          'password':password
        },
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    if(response.body == null) {
      Get.snackbar("Error", "No se pudo ejecutar la petición");
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}