import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/category.dart';
import 'package:gunanacos_app/src/models/product.dart';
import 'package:gunanacos_app/src/pages/client/products/detail/client_detail_page.dart';
import 'package:gunanacos_app/src/providers/categories_provider.dart';
import 'package:gunanacos_app/src/providers/products_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientProductsListController extends GetxController{
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  List<Category> categories = <Category>[].obs;

  ClientProductsListController(){
    getCategories();
  } 

  void goToOrderCreate(){
    Get.toNamed('/client/orders/create');
  } 

  void getCategories() async{
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProduct(int categoryId) async{
    return await productsProvider.findByCategory(categoryId);
  }

  void openModelBottomSheet(BuildContext context, Product product){
    showMaterialModalBottomSheet(
      context: context, 
      builder: (context) => ClientProductsDetailPage(product: product,)
    );
  }
}