import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login(){
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(isValidForm(email, password)){
      //Ready to call service
    }
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