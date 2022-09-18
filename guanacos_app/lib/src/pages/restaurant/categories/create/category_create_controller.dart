import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/category.dart';
import 'package:gunanacos_app/src/models/response_api.dart';
import 'package:gunanacos_app/src/providers/categories_provider.dart';

class CategoryCreateController extends GetxController {

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CategoriesProvider categoriesProvider = CategoriesProvider();

  void create(BuildContext context) async{
    String name = nameController.text;
    String description = descriptionController.text;

    if(name.isNotEmpty && description.isNotEmpty){
      Category category = Category(
        name: name,
        description: description
      );

      ResponseApi responseApi = await categoriesProvider.create(category);
      Get.snackbar('Proceso finalizado', responseApi.message ?? '');
      if(responseApi.success == true) {
        clearForm();
      }
    }else{
      Get.snackbar('Error', 'Ingrese todos los campos.');
    }
  }

  void clearForm(){
    nameController.text = '';
    descriptionController.text = '';
  }
  
}