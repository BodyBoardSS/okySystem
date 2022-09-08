import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/ResponseAPI.dart';

import 'package:gunanacos_app/src/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../models/User.dart';

class RegisterController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UserProvider userProvider = UserProvider();

  ImagePicker imgPicker = ImagePicker();
  File? imgFile;
  
  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void register(BuildContext context) async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if(isValidForm(email, name, lastName, phone, password, confirmPassword)){
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando...');

      User user = User(
        email: email,
        name: name,
        lastName: lastName,
        phone: phone,
        password: password,
        idrol: '2'
      );
      print('User: ${user.toJson()}');
      Stream stream = await userProvider.createWithImage(user, imgFile!);
      stream.listen((res) {
        print('User: ${res}');
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        if(responseApi.success == true){
          GetStorage().write('user', responseApi.data);
          goToHome();
        } else
          Get.snackbar('Error', responseApi.message ?? '');
      });
    }
  }

  void goToHome(){
    Get.offNamedUntil('/client/products/list', (route) => false);
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
    if(imgFile == null) {
      Get.snackbar("Alerta", 'Se debe seleccionar una imagen de perfil');
      return false;
    }

    return true;
  }

  void showAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
        onPressed: (){
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text('Gallery')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: (){
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text('Camera')
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Seleccione una opción'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );
    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await imgPicker.pickImage(source: imageSource);
    if(image != null){
      imgFile = File(image.path);
      update();
    }
  }
}