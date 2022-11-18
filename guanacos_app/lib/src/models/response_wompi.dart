// To parse this JSON data, do
//
//     final responseWompi = responseWompiFromJson(jsonString);

import 'dart:convert';

ResponseWompi responseWompiFromJson(String str) => ResponseWompi.fromJson(json.decode(str));

String responseWompiToJson(ResponseWompi data) => json.encode(data.toJson());

class ResponseWompi {
    String? idTransaccion;
    bool? esReal;
    bool? esAprobada;
    String? codigoAutorizacion;
    String? mensaje;
    String? formaPago;
    double? monto;

    ResponseWompi({
        this.idTransaccion,
        this.esReal,
        this.esAprobada,
        this.codigoAutorizacion,
        this.mensaje,
        this.formaPago,
        this.monto,
    });


    factory ResponseWompi.fromJson(Map<String, dynamic> json) => ResponseWompi(
        idTransaccion: json["idTransaccion"],
        esReal: json["esReal"],
        esAprobada: json["esAprobada"],
        codigoAutorizacion: json["codigoAutorizacion"],
        mensaje: json["mensaje"],
        formaPago: json["formaPago"],
        monto: json["monto"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "idTransaccion": idTransaccion,
        "esReal": esReal,
        "esAprobada": esAprobada,
        "codigoAutorizacion": codigoAutorizacion,
        "mensaje": mensaje,
        "formaPago": formaPago,
        "monto": monto,
    };
}
