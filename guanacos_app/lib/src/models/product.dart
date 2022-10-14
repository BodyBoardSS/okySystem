import 'dart:convert';

import 'package:guanacos_app/src/models/order_detail.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    int? id;
    String? name;
    double? price;
    String? description;
    String? image1;
    String? image2;
    String? image3;
    int? idCategory;
    int? quantity;
    OrderDetail? orderDetail;

    Product({
        this.id,
        this.name,
        this.price,
        this.description,
        this.image1,
        this.image2,
        this.image3,
        this.idCategory,
        this.quantity,
        this.orderDetail
    });

   

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"].toDouble(),
        description: json["description"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        idCategory: json["id_category"],
        quantity: json["quantity"],
        orderDetail: json["OrderDetail"] is String ? orderDetailFromJson(json["OrderDetail"]) : json["OrderDetail"] is OrderDetail ? json["OrderDetail"] : OrderDetail.fromJson(json["OrderDetail"] ?? {}),
    );

    static List<Product> fromJsonList(List<dynamic> jsonList){
      List<Product> list = [];
      for (var item in jsonList) {
        Product product = Product.fromJson(item);
        list.add(product);
      }

      return list;
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "id_category": idCategory,
        "quantity": quantity,
        "OrderDetail": orderDetail,
    };
}
