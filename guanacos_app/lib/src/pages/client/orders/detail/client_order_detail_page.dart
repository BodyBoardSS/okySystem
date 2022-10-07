import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/product.dart';
import 'package:gunanacos_app/src/pages/client/orders/detail/client_order_detail_controller.dart';
import 'package:gunanacos_app/src/widgets/no_data_widget.dart';
import 'package:gunanacos_app/src/widgets/relative_time_util.dart';

// ignore: must_be_immutable
class ClientOrderDetailPage extends StatelessWidget {
  ClientOrderDetailPage({Key? key}) : super(key: key);

  ClientOrderDetailController clientController =
      Get.put(ClientOrderDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: clientController.order.status == 'EN CAMINO'
        ? MediaQuery.of(context).size.height * 0.45
        : MediaQuery.of(context).size.height * 0.35,
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            _dataDate(),
            _dataDelivery(),
            _dataAddress(),
            _buttonTotalToPay(context),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Orden #${clientController.order.id}',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: clientController.order.products!.isNotEmpty
          ? ListView(
              children: clientController.order.products!.map((Product prod) {
                return _cardProduct(prod);
              }).toList(),
            )
          : Center(
              child: NoDataWidget(
              text: 'No se ha agregado ningún producto.',
            )),
    );
  }

  Widget _dataDelivery() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Repartidor y Teléfono'),
        subtitle: Text(
            '${clientController.order.delivery?.name ?? 'No Asignado'} ${clientController.order.delivery?.lastName ?? ''} - ${clientController.order.delivery?.phone ?? '####-####'}'),
        trailing: const Icon(Icons.person),
      ),
    );
  }

  Widget _dataAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Direccion de entrega'),
        subtitle: Text(clientController.order.address?.address ?? ''),
        trailing: const Icon(Icons.location_on),
      ),
    );
  }

  Widget _dataDate() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Fecha del pedido'),
        subtitle: Text(RelativeTimeUtil.getRelativeTime(
            clientController.order.createdDate ?? 0)),
        trailing: const Icon(Icons.timer),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imageProduct(product),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 7,
              ),
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
        Divider(
          height: 1,
          color: Colors.grey[300],
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 25),
          child: Row(
            mainAxisAlignment: clientController.order.status == 'EN CAMINO'
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                'Total: \$${clientController.order.total}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              clientController.order.status == 'EN CAMINO' 
              ? _buttonOrderMap() 
              : Container()
            ],
          ),
        )
      ],
    );
  }

  Widget _buttonOrderMap() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15), primary: Colors.amber),
            onPressed: () => clientController.goToOrderMap(),
            child: const Text(
              'Rastrear Pedido',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )));
  }
}
