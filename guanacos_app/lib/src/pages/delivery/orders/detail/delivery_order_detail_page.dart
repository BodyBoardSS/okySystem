import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/product.dart';
import 'package:gunanacos_app/src/pages/delivery/orders/detail/delivery_order_detail_controller.dart';
import 'package:gunanacos_app/src/widgets/no_data_widget.dart';
import 'package:gunanacos_app/src/widgets/relative_time_util.dart';

// ignore: must_be_immutable
class DeliveryOrderDetailPage extends StatelessWidget {
  DeliveryOrderDetailPage({Key? key}) : super(key: key);

  DeliveryOrderDetailController deliveryController =
      Get.put(DeliveryOrderDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.60,
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            _dataDate(),
            _dataClient(),
            _dataAddress(),
            _buttonTotalToPay(context),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Orden #${deliveryController.order.id}',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: deliveryController.order.products!.isNotEmpty
          ? ListView(
              children: deliveryController.order.products!.map((Product prod) {
                return _cardProduct(prod);
              }).toList(),
            )
          : Center(
              child: NoDataWidget(
              text: 'No se ha agregado ningún producto.',
            )),
    );
  }

  Widget _dataClient() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Cleinte y Telefono'),
        subtitle: Text(
            '${deliveryController.order.client?.name ?? ''} ${deliveryController.order.client?.lastName ?? ''} - ${deliveryController.order.client?.phone ?? ''}'),
        trailing: const Icon(Icons.person),
      ),
    );
  }

  Widget _dataAddress() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: const Text('Direccion de entrega'),
        subtitle: Text(deliveryController.order.address?.address ?? ''),
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
            deliveryController.order.createdDate ?? 0)),
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
            mainAxisAlignment: deliveryController.order.status == 'DESPACHADO'
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                'Total: \$${deliveryController.order.total}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              deliveryController.order.status == 'DESPACHADO'
                  ? _buttonUpdateOrder()
                  : deliveryController.order.status == 'EN CAMINO' ? _buttonOrderMap() 
                  : Container()
            ],
          ),
        )
      ],
    );
  }

  Widget _buttonUpdateOrder() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15), primary: Colors.amber),
            onPressed: () => deliveryController.updateOrder(),
            child: const Text(
              'Iniciar Entrega',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )));
  }

  Widget _buttonOrderMap() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15), primary: Colors.amber),
            onPressed: () => deliveryController.goToOrderMap(),
            child: const Text(
              'Volver a la ruta',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )));
  }
}
