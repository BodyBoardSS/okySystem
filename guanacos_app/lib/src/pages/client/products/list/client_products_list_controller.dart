import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guanacos_app/src/models/category.dart';
import 'package:guanacos_app/src/models/product.dart';
import 'package:guanacos_app/src/pages/client/products/detail/client_detail_page.dart';
import 'package:guanacos_app/src/providers/categories_provider.dart';
import 'package:guanacos_app/src/providers/products_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientProductsListController extends GetxController{
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  List<Category> categories = <Category>[].obs;
  List<Product> lstProducts = [];

  var items = 0.obs;
  var productName = ''.obs;
  Timer? searchOnStopedTyping;

  ClientProductsListController(){
    getCategories();
    if(GetStorage().read('shoppinBag') != null) {
      if(GetStorage().read('shoppinBag') is List<Product>) {
        lstProducts = GetStorage().read('shoppinBag');
      } else {
        lstProducts = Product.fromJsonList(GetStorage().read('shoppinBag'));
      }

      for (var p in lstProducts) {
        items.value = items.value + (p.quantity!);
      }

    }
  } 

  void goToOrderCreate(){
    Get.toNamed('/client/orders/create');
  } 

  void getCategories() async{
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProduct(int categoryId, String name) async{
    if(name.isEmpty){
      return await productsProvider.findByCategory(categoryId);
    }else {
      return await productsProvider.findByCategoryAndName(categoryId,name);
    }
  }

  void openModelBottomSheet(BuildContext context, Product product){
    showMaterialModalBottomSheet(
      context: context, 
      builder: (context) => ClientProductsDetailPage(product: product,)
    );
  }

  void onChangeText(String text){
    const duration = Duration(milliseconds: 800);
    if(searchOnStopedTyping != null){
      searchOnStopedTyping?.cancel();
    }

    searchOnStopedTyping = Timer(duration, (){
      productName.value = text;
    });
  }
}