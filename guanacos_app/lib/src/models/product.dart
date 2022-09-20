// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

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
    );

    static List<Product> fromJsonList(List<dynamic> jsonList){
      List<Product> list = [];
      jsonList.forEach((item) {
        Product product = Product.fromJson(item);
        list.add(product);
      });

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
    };
}
