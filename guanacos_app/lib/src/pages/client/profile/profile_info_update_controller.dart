import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guanacos_app/src/models/response_api.dart';
import 'package:guanacos_app/src/models/user.dart';
import 'package:guanacos_app/src/pages/client/profile/profile_info_controller.dart';
import 'package:guanacos_app/src/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';


class ProfileUpdateController extends GetxController{

  User user = User.fromJson(GetStorage().read('user') ?? {});
  UserProvider userProvider = UserProvider();
  ProfileInfoController profileInfoController = Get.find();
  
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  
  ImagePicker imgPicker = ImagePicker();
  File? imgFile;


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
        sessionToken: user.sessionToken
      );
      
      if(imgFile == null){
        ResponseApi responseApi = await userProvider.update(myUser);
        progressDialog.close();
        if(responseApi.success == true){
          GetStorage().write('user',responseApi.data);
          profileInfoController.user.value = User.fromJson(GetStorage().read('user') ?? {});
          Get.snackbar('Exito', responseApi.message ?? '');
        }
      } else {
          Stream stream = await userProvider.updateWithImage(myUser, imgFile!);
          stream.listen((res) {
            progressDialog.close();
            ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
            
            if(responseApi.success == true){
                GetStorage().write('user',responseApi.data);
                Get.snackbar('Exito', responseApi.message ?? '');
                profileInfoController.user.value = User.fromJson(GetStorage().read('user') ?? {});
            } else {
              Get.snackbar('Error', responseApi.message ?? '');
            }
          });
      }
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
        child: const Text(
          'Galería',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold
          )
        )
    );

    Widget cameraButton = ElevatedButton(
        onPressed: (){
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: const Text(
          'Camara',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold
          )
        )
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