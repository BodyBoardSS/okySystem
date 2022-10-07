import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/order.dart';

import 'package:gunanacos_app/src/pages/restaurant/order/list/restaurant_orders_list_controller.dart';
import 'package:gunanacos_app/src/widgets/no_data_widget.dart';
import 'package:gunanacos_app/src/widgets/relative_time_util.dart';

// ignore: must_be_immutable
class RestaurantOrdersListPage extends StatelessWidget {

  RestaurantOrdersListPage({Key? key}) : super(key: key);

  RestaurantOrdersListController restaurantController = Get.put(RestaurantOrdersListController());


  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
        length: restaurantController.status.length,
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
                    restaurantController.status.length, 
                    (index) {
                      return Tab(
                        child: Text(restaurantController.status[index]),
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
        children: restaurantController.status.map((String status){
          return FutureBuilder(
            future:restaurantController.getOrders(status),
            builder: (context, AsyncSnapshot<List<Order>> snapshot) {
              if(snapshot.hasData && snapshot.data!.isNotEmpty){
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_,index){
                    return _cardOrder(snapshot.data![index]);
                  }
                );
              }else{
                return Center(child: NoDataWidget(text:'No hay ordenes'));
              }
            }
          );
        }).toList(),
      );
  }

  Widget _cardOrder(Order order){
    return GestureDetector(
      onTap: () => restaurantController.goToOrderDetail(order),
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text(
                    'Orden #${order.id}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text('Pedido: ${RelativeTimeUtil.getRelativeTime( order.createdDate ?? 0)}')
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text('Cliente: ${order.client?.name ??''} ${order.client?.lastName ??''}')
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text('Entregar en: ${order.address?.address ??''}')
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
