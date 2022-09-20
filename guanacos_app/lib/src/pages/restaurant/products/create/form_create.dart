import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/category.dart';
import 'package:gunanacos_app/src/pages/restaurant/products/create/product_create_controller.dart';

// ignore: must_be_immutable
class FormCreate extends StatelessWidget {
  FormCreate({Key? key}) : super(key: key);

  ProductCreateController productCreateController =
      Get.put(ProductCreateController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 50,
            right: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _txtInfo(),
              const SizedBox(
                height: 10,
              ),
              _txtFieldName(),
              const SizedBox(
                height: 10,
              ),
              _txtFieldDescription(),
              const SizedBox(
                height: 10,
              ),
              _txtFieldPrice(),
              _dropDownCategories(productCreateController.categories),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<ProductCreateController>(
                      builder: (value) =>_cardImage(productCreateController.imgFile1, 1, context)
                    ),
                    GetBuilder<ProductCreateController>(
                      builder: (value) =>_cardImage(productCreateController.imgFile2, 2, context)
                    ),
                    GetBuilder<ProductCreateController>(
                      builder: (value) =>_cardImage(productCreateController.imgFile3, 3, context)
                    ),
                  ],
                ),
              ),
              _buttonCreate(context)
            ],
          )),
        ));
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      margin: const EdgeInsets.only(top: 15),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.amber,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: const Text(
          'Seleccionar categoria',
          style: TextStyle(

            fontSize: 15
          ),
        ),
        items: _dropDownItems(categories),
        value: productCreateController.idCategory.value == 0 ? null : productCreateController.idCategory.value.toInt(),
        onChanged: (option) {
          productCreateController.idCategory.value = int.parse(option.toString());
        },
      ),
    );
  }

  List<DropdownMenuItem<int>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<int>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
          value: category.id,
          child: Text(category.name ?? ''),
      ));
    });

    return list;
  }

  

  Widget _cardImage(File? imageFile, int numberFile, BuildContext context) {
    return GestureDetector(
        onTap: () =>
            productCreateController.showAlertDialog(context, numberFile),
        child: Card(
          elevation: 3,
          child: SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.18,
              child: imageFile != null
                  ? Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    )
                  : const Image(image: AssetImage('assets/img/no-image.png'))
            ),
        ));
  }

  Widget _txtInfo() {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        child: const Text('Ingrese esta informacion',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)));
  }

  Widget _txtFieldName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: productCreateController.nameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Nombre', prefixIcon: Icon(Icons.restaurant_menu)),
      ),
    );
  }

  Widget _txtFieldPrice() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: productCreateController.priceController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            hintText: 'Precio', prefixIcon: Icon(Icons.attach_money)),
      ),
    );
  }

  Widget _txtFieldDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: productCreateController.descriptionController,
        maxLines: 4,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Descripción', prefixIcon: Icon(Icons.description)),
      ),
    );
  }
  

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ElevatedButton(
          onPressed: () => productCreateController.create(context),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15)),
          child: const Text(
            'Crear',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          )),
    );
  }
}
