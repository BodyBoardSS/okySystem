import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guanacos_app/src/models/response_api.dart';
import 'package:guanacos_app/src/models/user.dart';
import 'package:guanacos_app/src/providers/user_provider.dart';

class LoginController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserProvider userProvider = UserProvider();
  
  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(isValidForm(email, password)){
      ResponseApi responseApi = await userProvider.login(email, password);

      if(responseApi.success == true){
        GetStorage().write('user', responseApi.data);
        User myUser = User.fromJson(GetStorage().read('user') ?? {});
        if(myUser.roles!.length > 1) {
          goToRolesPage();
        } else {
          goToClientHomePage();
        }
      }
    }
  }

  void goToClientHomePage() {
    Get.offNamedUntil('/client/home', (route) => false);
  }
  void goToRolesPage(){
    Get.offNamedUntil('/roles', (route) => false);
  }

  bool isValidForm(String email, String password){

    if(email.isEmpty) {
      Get.snackbar("Datos fallidos", 'Debe ingresar un correo');
      return false;
    }

    if(!GetUtils.isEmail(email)) {
      Get.snackbar("Datos fallidos", 'Debe ingresar un correo valido');
      return false;
    }

    if(password.isEmpty) {
      Get.snackbar("Datos fallidos", 'Debe ingresar una contraseña');
      return false;
    }

    return true;
  }
}