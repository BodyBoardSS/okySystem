import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/models/product.dart';
import 'package:guanacos_app/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:guanacos_app/src/widgets/no_data_widget.dart';

// ignore: must_be_immutable
class ClientOrdersCreatePage extends StatelessWidget {
  ClientOrdersCreatePage({Key? key}) : super(key: key);

  ClientOrdersCreateController orderController =
      Get.put(ClientOrdersCreateController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar: SizedBox(
        height: 100,
        child: _buttonTotalToPay(context),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Mi Orden',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: orderController.lstProducts.isNotEmpty 
          ? ListView(
            children: orderController.lstProducts.map((Product prod){
              return _cardProduct(prod);
            }).toList(),
          ) : Center(child: NoDataWidget(text: 'No se ha agregado ningún producto.',)),
    ));
  }

  Widget _iconDelete(Product product){
    return IconButton(
      onPressed: ()=>orderController.deleteItem(product), 
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      )
    );
  }

  Widget _textPrice(Product product){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        '\$${(product.price! * product.quantity!).toStringAsFixed(2)}',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),
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
              const SizedBox(height: 10,),
              _buttonsAddOrRemove(product)
            ],
          ),
          const Spacer(),
          Column(
            children: [
              _textPrice(product),
              _iconDelete(product)
            ],
          )
        ],
      ),
    );
  }

  Widget _buttonsAddOrRemove(Product product){
    return Row(
      children: [
        GestureDetector(
          onTap: ()=> orderController.removeItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8)
              ),
              color: Colors.grey[200],
            ),
            child: const Text('-'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
          color: Colors.grey[200],
          child: Text((product.quantity ?? 0).toString()),
        ),
        GestureDetector(
          onTap: ()=>orderController.addItem(product),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
            decoration:  BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8)
              ),
              color: Colors.grey[200],
            ),
            child: const Text('+'),
          ),
        )
      ],
    );
  }

  Widget _imageProduct(Product product) {
    return SizedBox(
      height: 70,
      width: 70,
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
        Divider(height: 1, color: Colors.grey[400],),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                   Text(
                    'Total: \$${orderController.total.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15)
                      ),
                      onPressed: ()=> orderController.goToAddressList(), 
                      child: const Text(
                        'Confirmar Orden',
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )
                    ),
                  )
            ],
          ),
        )
      ],
    );
  }

}

