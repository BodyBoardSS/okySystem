import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gunanacos_app/src/models/response_api.dart';
import 'package:gunanacos_app/src/models/user.dart';
import 'package:gunanacos_app/src/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';


class ProfileUpdateController extends GetxController{

  User user = User.fromJson(GetStorage().read('user') ?? {});

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  
  ImagePicker imgPicker = ImagePicker();
  File? imgFile;

  UserProvider userProvider = UserProvider();

  ProfileUpdateController(){
    nameController.text = user.name??'';
    lastNameController.text = user.lastName??'';
    phoneController.text = user.phone??'';
  }

  void updateUser(BuildContext context)async{
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;

    if(isValidForm(name, lastName, phone)){
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Actualizando...');

      User myUser = User(
        id: user.id,
        name: name,
        lastName: lastName,
        phone: phone,
      );

      Stream stream = await userProvider.createWithImage(myUser, imgFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        if(responseApi.success == true){
          GetStorage().write('user', responseApi.data);
        } else {
          Get.snackbar('Error', responseApi.message ?? '');
        }
      });
    }
  }

   bool isValidForm(String name, String lastName, String phone){

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

    return true;
  }

  void showAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
        onPressed: (){
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: const Text('Gallery')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: (){
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: const Text('Camera')
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Seleccione una opción'),
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