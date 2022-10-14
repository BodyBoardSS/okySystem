import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/models/category.dart';
import 'package:guanacos_app/src/models/product.dart';
import 'package:guanacos_app/src/models/response_api.dart';
import 'package:guanacos_app/src/providers/categories_provider.dart';
import 'package:guanacos_app/src/providers/products_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ProductCreateController extends GetxController {

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();


  ImagePicker imgPicker = ImagePicker();
  File? imgFile1;
  File? imgFile2;
  File? imgFile3;

  var idCategory = 0.obs;

  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  List<Category> categories = <Category>[].obs;

  ProductCreateController(){
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }


  void create(BuildContext context) async{
    String name = nameController.text;
    String description = descriptionController.text;
    String price = priceController.text;
    int categoryId = idCategory.value;

    ProgressDialog progressDialog = ProgressDialog(context: context);

    if(isValidForm(name, description, price, categoryId)){

      Product product = Product(
        name: name,
        description: description,
        price: double.parse(price),
        idCategory: idCategory.value
      );

      progressDialog.show(max: 100, msg: 'Espere un momento...');

      List<File> images = [];
      images.add(imgFile1!);
      images.add(imgFile2!);
      images.add(imgFile3!);

      Stream stream = await productsProvider.create(product, images);
      stream.listen((res) {
        progressDialog.close();

        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Get.snackbar('Proceso terminado', responseApi.message?? '');
        if(responseApi.success == true) {
          clearForm();
        }
      });
    }
  }

  bool isValidForm(String name, String description, String price, int categoryId){
    
    if(name.isEmpty) {
      Get.snackbar("Datos fallidos", 'Debe ingresar un nombre');
      return false;
    }

    if(description.isEmpty) {
      Get.snackbar("Datos fallidos", 'Debe ingresar una descripción del producto');
      return false;
    }

    if(price.isEmpty) {
      Get.snackbar("Datos fallidos", 'Debe ingresar el precio del producto');
      return false;
    }

    if(categoryId == 0) {
      Get.snackbar("Datos fallidos", 'Debe seleccionar una categoria');
      return false;
    }

    if(imgFile1 == null) {
      Get.snackbar("Datos fallidos", 'Seleccionar la imagen 1');
      return false;
    }

    if(imgFile2 == null) {
      Get.snackbar("Datos fallidos", 'Seleccionar la imagen 2');
      return false;
    }

    if(imgFile3 == null) {
      Get.snackbar("Datos fallidos", 'Seleccionar la imagen 3');
      return false;
    }

    return true;
  }

  void clearForm(){
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    idCategory.value = 0;
    imgFile1 = null;
    imgFile2 = null;
    imgFile3 = null;
    update();
  }

   void showAlertDialog(BuildContext context, int numberFile){
    Widget galleryButton = ElevatedButton(
        onPressed: (){
          Get.back();
          selectImage(ImageSource.gallery, numberFile);
        },
        child: const Text('Gallery')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: (){
          Get.back();
          selectImage(ImageSource.camera, numberFile);
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

  Future selectImage(ImageSource imageSource, int numberFile) async {
    XFile? image = await imgPicker.pickImage(source: imageSource);
    if(image != null){

      if(numberFile == 1) {
        imgFile1 = File(image.path);
      } else if (numberFile == 2) {
        imgFile2 = File(image.path);
      } else if (numberFile == 3) {
        imgFile3 = File(image.path);
      }

      update();
    }
  }
}