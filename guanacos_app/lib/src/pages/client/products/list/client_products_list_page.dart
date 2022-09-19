import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/category.dart';

import 'package:gunanacos_app/src/pages/client/products/list/client_products_list_controller.dart';

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
            preferredSize:const Size.fromHeight(50),
            child: AppBar(
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
          body: _tabBarView(),
        ),
      )
    );
  }

  TabBarView _tabBarView() {
    return TabBarView(
        children: clientController.categories.map((Category category){
          return Container();
        }).toList(),
      );
  }

}
