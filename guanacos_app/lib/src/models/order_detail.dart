import 'dart:convert';

OrderDetail orderDetailFromJson(String str) => OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
    int? quantity;
    int? idorder;
    int? idproduct;

    OrderDetail({
        this.quantity,
        this.idorder,
        this.idproduct,
    });


    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        quantity: json["quantity"],
        idorder: json["idorder"],
        idproduct: json["idproduct"],
    );

    Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "idorder": idorder,
        "idproduct": idproduct,
    };
}
