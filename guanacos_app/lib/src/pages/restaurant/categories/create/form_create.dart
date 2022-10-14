import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/pages/restaurant/categories/create/category_create_controller.dart';

// ignore: must_be_immutable
class FormCreate extends StatelessWidget {
  FormCreate({Key? key}) : super(key: key);

  CategoryCreateController categoryController =  Get.put(CategoryCreateController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.30, left: 50, right: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _txtInfo(),
            const SizedBox(height: 10,),
            _txtFieldName(),
            const SizedBox(height: 10,),
            _txtFieldDescription(),
            const SizedBox(height: 10,),
            _buttonCreate(context)
          ],
        ),
      )
    );
  }

   Widget _txtInfo() {
    return Container(
        margin:const EdgeInsets.only(top: 10, bottom: 20),
        child:const Text('Ingrese esta informacion',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)));
  }


  Widget _txtFieldName() {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: categoryController.nameController,
        keyboardType: TextInputType.text,
        decoration:const InputDecoration(
            hintText: 'Nombre', prefixIcon: Icon(Icons.category)),
      ),
    );
  }

  Widget _txtFieldDescription() {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: categoryController.descriptionController,
        maxLines: 4,
        keyboardType: TextInputType.text,
        decoration:const InputDecoration(
            hintText: 'Descripción', prefixIcon: Icon(Icons.description)),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ElevatedButton(
          onPressed: () => categoryController.create(context),
          style: ElevatedButton.styleFrom(
              padding:const EdgeInsets.symmetric(vertical: 15)),
          child:const Text(
            'Crear',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          )),
    );
  }
}