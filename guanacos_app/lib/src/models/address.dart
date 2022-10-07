import 'dart:convert';

List<Address> addressFromJson(String str) => List<Address>.from(json.decode(str).map((x) => Address.fromJson(x)));

String addressToJson(List<Address> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Address {
    int? id;
    String? address;
    String? neighborhood;
    double? lat;
    double? lng;
    int? userid;

    Address({
        this.id,
        this.address,
        this.neighborhood,
        this.lat,
        this.lng,
        this.userid,
    });


    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        address: json["address"],
        neighborhood: json["neighborhood"],
        lat: json["lat"],
        lng: json["lng"],
        userid: json["userid"],
    );

    static List<Address> fromJsonList(List<dynamic> jsonList){
      List<Address> list = [];
      for (var item in jsonList) {
        Address address = Address.fromJson(item);
        list.add(address);
      }

      return list;
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "neighborhood": neighborhood,
        "lat": lat,
        "lng": lng,
        "userid": userid,
    };
}
