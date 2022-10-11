import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/product.dart';
import 'package:gunanacos_app/src/pages/client/products/detail/client_products_detail_controller.dart';

// ignore: must_be_immutable
class ClientProductsDetailPage extends StatelessWidget {
  Product? product;
  late ClientProductsDetailController clientProductsDetailController;

  var counter = 0.obs;
  var price = 0.0.obs;

  ClientProductsDetailPage({Key? key, @required this.product}) : super(key: key){
    clientProductsDetailController = Get.put(ClientProductsDetailController());
  }

  @override
  Widget build(BuildContext context) {

    clientProductsDetailController.checkProductsAdded(product!, price, counter);

    return Obx(() => Scaffold(
      bottomNavigationBar: SizedBox(
        height: 100,
        child: _buttonAddToBag(),
      ),
      body: Column(
        children: [
          _imageSlideShow(context),
          _productName(),
          _productDescription(),
          _productPrice()
        ],
      ),
    ));
  }

  Widget _productName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.name ?? '',
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
      ),
    );
  }

  Widget _productDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.description ?? '',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _productPrice() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 15, left: 30, right: 30),
      child: Text(
        '\$${product?.price!.toStringAsFixed(2) ?? '0.0'}',
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget _buttonAddToBag() {
    return Column(
      children: [
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30, top:25 ),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => clientProductsDetailController.removeItem(product!, price, counter),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(45,37),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25)))),
                child: const Text(
                  '-',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(45,37),
                ),
                child: Text(
                  '${counter.value}',
                  style: const TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
              ElevatedButton(
                onPressed: () => clientProductsDetailController.addItem(product!, price, counter),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(45,37),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25)))),
                child: const Text(
                  '+',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => clientProductsDetailController.addToBag(product!, price, counter),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(45,37),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      )
                    ),
                child: Text(
                  'Agregar   \$${price.value.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _imageSlideShow(BuildContext context) {
    return  ImageSlideshow(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            initialPage: 0,
            indicatorColor: Colors.amber,
            indicatorBackgroundColor: Colors.grey,
            children: [
              FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                  image: product!.image1 != null
                      ? NetworkImage(product!.image1!)
                      : const AssetImage('assets/img/no-image.png')
                          as ImageProvider),
              FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                  image: product!.image2 != null
                      ? NetworkImage(product!.image2!)
                      : const AssetImage('assets/img/no-image.png')
                          as ImageProvider),
              FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 50),
                  placeholder: const AssetImage('assets/img/no-image.png'),
                  image: product!.image3 != null
                      ? NetworkImage(product!.image3!)
                      : const AssetImage('assets/img/no-image.png')
                          as ImageProvider),
            ]);
  }
}
