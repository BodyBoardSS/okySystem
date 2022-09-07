import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/providers/user_provider.dart';

import '../../models/User.dart';

class RegisterController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UserProvider userProvider = UserProvider();
  
  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void register() async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if(isValidForm(email, name, lastName, phone, password, confirmPassword)){
      User user = User(
        email: email,
        name: name,
        lastName: lastName,
        phone: phone,
        password: password,
        idrol: '2'
      );

      Response response = await userProvider.create(user);
      print('Response: ${response.body}');
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