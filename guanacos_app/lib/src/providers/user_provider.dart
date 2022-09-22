import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/user.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

import 'package:gunanacos_app/src/environment/environment.dart';
import 'package:gunanacos_app/src/models/response_api.dart';



class UserProvider extends GetConnect {
  String url = "${Environment.apiUrl}api";

  User user = User.fromJson(GetStorage().read('user') ?? {});

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
    Uri uri = Uri.http(Environment.apiUrlOld, '/api/signUpWithImage');

    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(img.openRead().cast()),
      await img.length(),
      filename: p.basename(img.path)
    ));

    request.fields['user'] = json.encode(user);

    final response = await request.send();

    return response.stream.transform(utf8.decoder);
  }

  Future<Stream> updateWithImage(User user, File img) async{
    Uri uri = Uri.http(Environment.apiUrlOld, '/api/users/updateWithImage');
    final request = http.MultipartRequest('PUT', uri);
    request.headers['Authorization'] = user.sessionToken ?? '';
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(img.openRead().cast()),
      await img.length(),
      filename: p.basename(img.path)
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

    if(response.statusCode == 500) {
      Get.snackbar("Error", "Lo sentimos estamos teniendo algunos problemas, favor vuelva a intentarlo mas tarde.");
      return ResponseApi();
    }

    if(response.statusCode == 401) {
      Get.snackbar("Error", "No está autorizado para realizar esta petición");
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> update(User user) async{

    Response response = await put(
        '$url/users',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.sessionToken ?? ''
        }
    );
    

    if(response.statusCode == 500) {
      Get.snackbar("Error", "Lo sentimos estamos teniendo algunos problemas, favor vuelva a intentarlo mas tarde.");
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}