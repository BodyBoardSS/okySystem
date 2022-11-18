import 'dart:convert';

RequestWompi requestWompiFromJson(String str) => RequestWompi.fromJson(json.decode(str));

String requestWompiToJson(RequestWompi data) => json.encode(data.toJson());

class RequestWompi {
    TarjetaCreditoDebido? tarjetaCreditoDebido;
    double? monto;
    String? emailCliente;
    String? nombreCliente;

    RequestWompi({
        this.tarjetaCreditoDebido,
        this.monto,
        this.emailCliente,
        this.nombreCliente,
    });


    factory RequestWompi.fromJson(Map<String, dynamic> json) => RequestWompi(
        tarjetaCreditoDebido: TarjetaCreditoDebido.fromJson(json["tarjetaCreditoDebido"]),
        monto: json["monto"].toDouble(),
        emailCliente: json["emailCliente"],
        nombreCliente: json["nombreCliente"],
    );

    Map<String, dynamic> toJson() => {
        "tarjetaCreditoDebido": tarjetaCreditoDebido?.toJson(),
        "monto": monto,
        "emailCliente": emailCliente,
        "nombreCliente": nombreCliente,
    };
}

class TarjetaCreditoDebido {
    String? numeroTarjeta;
    String? cvv;
    int? mesVencimiento;
    int? anioVencimiento;

    TarjetaCreditoDebido({
        this.numeroTarjeta,
        this.cvv,
        this.mesVencimiento,
        this.anioVencimiento,
    });


    factory TarjetaCreditoDebido.fromJson(Map<String, dynamic> json) => TarjetaCreditoDebido(
        numeroTarjeta: json["numeroTarjeta"],
        cvv: json["cvv"],
        mesVencimiento: json["mesVencimiento"],
        anioVencimiento: json["anioVencimiento"],
    );

    Map<String, dynamic> toJson() => {
        "numeroTarjeta": numeroTarjeta,
        "cvv": cvv,
        "mesVencimiento": mesVencimiento,
        "anioVencimiento": anioVencimiento,
    };
}
