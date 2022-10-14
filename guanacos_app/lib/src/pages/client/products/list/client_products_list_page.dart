import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/models/category.dart';
import 'package:guanacos_app/src/models/product.dart';

import 'package:guanacos_app/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:guanacos_app/src/widgets/no_data_widget.dart';

// ignore: must_be_immutable
class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController clientController = Get.put(ClientProductsListController());

  ClientProductsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
        length: clientController.categories.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:const Size.fromHeight(110),
            child: AppBar(
                flexibleSpace: Container(
                  margin: const EdgeInsets.only(top: 15),
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      _textFieldSearch(context),
                      _iconShoppingBag(),
                    ],
                  ),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.amber,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[400],
                  tabs:List<Widget>.generate(
                    clientController.categories.length, 
                    (index) {
                      return Tab(
                        child: Text(clientController.categories[index].name ?? ''),
                      );
                    }),
                ),
              ),
          ),
          body: _tabBarView(context),
        ),
      )
    );
  }

  TabBarView _tabBarView(BuildContext context) {
    return TabBarView(
        children: clientController.categories.map((Category category){
          return FutureBuilder(
            future:clientController.getProduct(category.id ?? 2, clientController.productName.value),
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if(snapshot.hasData && snapshot.data!.isNotEmpty){
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_,index){
                    return _cardProduct(context,snapshot.data![index]);
                  }
                );
              }else{
                return NoDataWidget(text:'No hay productos');
              }
            }
          );
        }).toList(),
      );
  }

  Widget _cardProduct(BuildContext context,Product product){
    return GestureDetector(
      onTap: () => clientController.openModelBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              title: Text(product.name ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(product.description ?? '',
                    maxLines:2 ,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Text('\$ ${(product.price)!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              trailing: SizedBox(
                height: 70,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/img/no-image.png'), 
                    image: product.image1 != null ? NetworkImage(product.image1!) 
                    : const AssetImage('assets/img/no-image.png') as ImageProvider,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 50),
                  ),
                ),
              ),
            ),
          ),
          const Divider(height: 1,color: Colors.grey,indent: 37, endIndent: 37,)
        ],
      ),
    );
  }

  Widget _iconShoppingBag(){
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: clientController.items.value > 0 ?
        Stack(
          children: [
            IconButton(
              onPressed: () => clientController.goToOrderCreate(), 
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 35,
              )
            ),
            Positioned(
              right: 4,
              top: 12,
              child: Container(
                width: 16,
                height: 16,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text(
                  '${clientController.items.value}',
                  style: const TextStyle(
                    fontSize: 12,

                  ),
                ),
              )
            )
          ],
        )
        : IconButton(
              onPressed: () => clientController.goToOrderCreate(), 
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 30,
              )
            )
      ),
    );
  }

  Widget _textFieldSearch(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: TextField(
          onChanged: clientController.onChangeText,
          decoration: InputDecoration(
            hintText: 'Buscar',
            suffixIcon: const Icon(Icons.search, color: Colors.grey,),
            hintStyle: const TextStyle(
              fontSize: 17,
              color: Colors.grey
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.grey
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.grey
              )
            ),
            contentPadding: const EdgeInsets.all(15)
          ),
        ),
      ),
    );
  }

}
