import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/category.dart';
import 'package:gunanacos_app/src/models/product.dart';
import 'package:gunanacos_app/src/providers/categories_provider.dart';
import 'package:gunanacos_app/src/providers/products_provider.dart';

class ClientProductsListController extends GetxController{
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  List<Category> categories = <Category>[].obs;

  ClientProductsListController(){
    getCategories();
  }  

  void getCategories() async{
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProduct(int categoryId) async{
    return await productsProvider.findByCategory(categoryId);
  }
}