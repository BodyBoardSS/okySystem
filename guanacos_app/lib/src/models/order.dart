import 'dart:convert';

import 'package:guanacos_app/src/models/address.dart';
import 'package:guanacos_app/src/models/product.dart';
import 'package:guanacos_app/src/models/user.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
    int? id;
    double? lat;
    double? lng;
    double? total;
    String? status;
    int? createdDate;
    int? idclient;
    int? iddelivery;
    int? idaddress;
    List<Product>? detail;
    User? client;
    User? delivery;
    Address? address;
    List<Product>? products;

    Order({
        this.id,
        this.lat,
        this.lng,
        this.status,
        this.createdDate,
        this.idclient,
        this.iddelivery,
        this.idaddress,
        this.detail,
        this.client,
        this.address,
        this.products,
        this.total,
        this.delivery
    });


    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        lat: json["lat"],
        lng: json["lng"],
        total: json["total"] is int ? json["total"].toDouble() : json["total"],
        status: json["status"],
        createdDate: json["createdDate"],
        idclient: json["idclient"],
        iddelivery: json["iddelivery"],
        idaddress: json["idaddress"],
        detail: json["detail"] != null? List<Product>.from(json["detail"].map((x) => Product.fromJson(x))) : [],
        products: json["products"] != null ? List<Product>.from(json["products"].map((x) => x is Product ? x : Product.fromJson(x))) : [],
        client: json['client'] is String ? userFromJson(json['client']) : json['client'] is User ? json['client'] : User.fromJson(json['client'] ?? {}),
        delivery: json['delivery'] is String ? userFromJson(json['delivery']) : json['delivery'] is User ? json['delivery'] : User.fromJson(json['delivery'] ?? {}),
        address: json["address"] is String ? addressFromJson(json["address"]) : json["address"] is Address ? json["address"] : Address.fromJson(json["address"] ?? {}),
    );

    static List<Order> fromJsonList(List<dynamic> jsonList){
      List<Order> list = [];
      for (var item in jsonList) {
        Order order = Order.fromJson(item);
        list.add(order);
      }

      return list;
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lng": lng,
        "total": total,
        "status": status,
        "createdDate": createdDate,
        "idclient": idclient,
        "iddelivery": iddelivery,
        "idaddress": idaddress,
        "detail": List<dynamic>.from(detail!.map((x) => x.toJson())),
        "client": client,
        "address": address,
        "produts": products,
        "delivery": delivery
    };
}
