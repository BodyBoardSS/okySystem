import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/product.dart';
import 'package:gunanacos_app/src/models/user.dart';
import 'package:gunanacos_app/src/pages/restaurant/order/detail/restaurant_order_detail_controller.dart';
import 'package:gunanacos_app/src/widgets/no_data_widget.dart';
import 'package:gunanacos_app/src/widgets/relative_time_util.dart';

// ignore: must_be_immutable
class RestaurantOrderDetailPage extends StatelessWidget {
   RestaurantOrderDetailPage({Key? key}) : super(key: key);

  RestaurantOrderDetailController restaurantController = Get.put(RestaurantOrderDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: restaurantController.order.status == 'PAGADO' ? 
        MediaQuery.of(context).size.height*0.70
        : MediaQuery.of(context).size.height*0.70,
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            _dataDate(),
            _dataClient(),
            _dataAddress(),
            _dataDelivery(),
            _buttonTotalToPay(context),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Orden #${restaurantController.order.id}',
          style: const TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: restaurantController.order.products!.isNotEmpty 
          ? ListView(
            children: restaurantController.order.products!.map((Product prod){
              return _cardProduct(prod);
            }).toList(),
          ) : Center(child: NoDataWidget(text: 'No se ha agregado ningún producto.',)),
    );
  }

  Widget _dataClient(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Cleinte y Telefono'),
        subtitle: Text('${restaurantController.order.client?.name ?? ''} ${restaurantController.order.client?.lastName ?? ''} - ${restaurantController.order.client?.phone ?? ''}'),
        trailing: const Icon(Icons.person),
      ),
    );
  }

  Widget _dataDelivery(){
    return restaurantController.order.status != 'PAGADO' ? Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Repartidor asignado'),
        subtitle: Text('${restaurantController.order.delivery?.name ?? ''} ${restaurantController.order.delivery?.lastName ?? ''} - ${restaurantController.order.delivery?.phone ?? ''}'),
        trailing: const Icon(Icons.delivery_dining)
      ),
    ) : Container();
  }

  Widget _dataAddress(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Direccion de entrega'),
        subtitle: Text(restaurantController.order.address?.address ?? ''),
        trailing: const Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataDate(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Fecha del pedido'),
        subtitle: Text(RelativeTimeUtil.getRelativeTime(restaurantController.order.createdDate ?? 0 )),
        trailing: const Icon(Icons.timer),
      ),
    );
  }

   Widget _cardProduct(Product product){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          const SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 7,),
              Text(
                'Cantidad: ${product.orderDetail!.quantity}',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return SizedBox(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage(
          placeholder: const AssetImage('assets/img/no-image.png'),
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : const AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 50),
        ),
      ),
    );
  }

    Widget _buttonTotalToPay(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey[300],),
        restaurantController.order.status == 'PAGADO'? Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 30, top: 10),
          child: const Text(
            'Asignar repartidor',
            style: TextStyle(
              fontStyle: FontStyle.italic
            ),
          ),
        ): Container(),
        restaurantController.order.status == 'PAGADO'? _dropDownDelivery(restaurantController.users) : Container(),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 25),
          child: Row(
            mainAxisAlignment: restaurantController.order.status == 'PAGADO'? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
                   Text(
                    'Total: \$${restaurantController.order.total}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  restaurantController.order.status == 'PAGADO'? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15)
                      ),
                      onPressed: () => restaurantController.updateOrder(), 
                      child: const Text(
                        'Despachar Orden',
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )
                    ),
                  ): Container()
            ],
          ),
        )
      ],
    );
  }

  Widget _dropDownDelivery(List<User> users) {
    return Obx(() =>Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
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
          'Seleccionar repartidor',
          style: TextStyle(

            fontSize: 15
          ),
        ),
        items: _dropDownItems(users),
        value: restaurantController.idDelivery.value == 0 ? null : restaurantController.idDelivery.value.toInt(),
        onChanged: (option) {
          restaurantController.idDelivery.value = int.parse(option.toString());
        },
      ),
    ));
  }


  List<DropdownMenuItem<int>> _dropDownItems(List<User> users) {
    List<DropdownMenuItem<int>> list = [];
    for (var user in users) {
      list.add(DropdownMenuItem(
          value: user.id,
          child: Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: FadeInImage(
                  image: user.image != null
                  ? NetworkImage(user.image!)
                  : const AssetImage('assets/img/no-image.png') as ImageProvider,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png') ,
                ),
              ),
              const SizedBox(width: 15,),
              Text(user.name ?? ''),
            ],
          ),
      ));
    }

    return list;
  }
}