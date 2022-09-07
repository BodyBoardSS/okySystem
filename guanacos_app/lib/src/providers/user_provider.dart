import 'package:get/get.dart';
import 'package:gunanacos_app/src/environment/environment.dart';

import '../models/User.dart';

class UserProvider extends GetConnect {
  String url = Environment.API_URL+"api";

  Future<Response> create(User user) async{
    print('$url/signUpWithImage');
    print(user.toJson());
    Response response = await post(
      '$url/signUpWithImage',
      user.toJson(),
      headers: {
        'Content-Type' : 'application/json'
      }
    );

    return response;
  }
}