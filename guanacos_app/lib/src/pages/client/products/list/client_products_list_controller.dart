import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/category.dart';
import 'package:gunanacos_app/src/providers/categories_provider.dart';

class ClientProductsListController extends GetxController{
  CategoriesProvider categoriesProvider = CategoriesProvider();

  List<Category> categories = <Category>[].obs;

  ClientProductsListController(){
    getCategories();
  }  

  void getCategories() async{
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  } 
}