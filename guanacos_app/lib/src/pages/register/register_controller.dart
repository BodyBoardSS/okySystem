import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  
  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void register(){
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if(isValidForm(email, name, lastName, phone, password, confirmPassword)){
      //Ready to call service
    }
  }

  bool isValidForm(String email, String name, String lastName, String phone, String password, String confirmPassword){

    if(email.isEmpty) {
      Get.snackbar("Datos fallidos", 'Debe ingresar un correo');
      return false;
    }

    if(!GetUtils.isEmail(email)) {
      Get.snackbar("Datos fallidos", 'Debe ingresar un correo valido');
      return false;
    }

    if(name.isEmpty) {
      Get.snackbar("Datos fallidos", 'Debe ingresar un nombre');
      return false;
    }

    if(lastName.isEmpty) {
      Get.snackbar("Datos fallidos", 'Debe ingresar un apellido');
      return false;
    }

    if(phone.isEmpty) {
      Get.snackbar("Datos fallidos", 'Debe ingresar un teléfono');
      return false;
    }

    if(password.isEmpty) {
      Get.snackbar("Datos fallidos", 'Debe ingresar una contraseña');
      return false;
    }

    if(confirmPassword.isEmpty) {
      Get.snackbar("Datos fallidos", 'Debe ingresar la confirmación de la contraseña');
      return false;
    }

    if(password != confirmPassword) {
      Get.snackbar("Datos fallidos", 'Contraseñas no coinciden');
      return false;
    }

    return true;
  }
}