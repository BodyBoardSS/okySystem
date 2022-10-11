import 'dart:convert';

import 'package:gunanacos_app/src/models/rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    int? id;
    String? name;
    String? lastName;
    String? email;
    String? phone;
    String? image;
    String? password;
    String? idrol;
    List<Rol>? roles;
    String? sessionToken;
    String? notificationToken;

    User({
        this.id,
        this.name,
        this.lastName,
        this.email,
        this.phone,
        this.image,
        this.password,
        this.roles,
        this.sessionToken,
        this.idrol,
        this.notificationToken
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        password: json["password"],
        idrol: json["idrol"],
        roles: json["roles"] == null ? [] : List<Rol>.from(json["roles"].map((x) => Rol.fromJson(x))),
        sessionToken: json["session_token"],
        notificationToken: json["notificationToken"],
    );

    static List<User> fromJsonList(List<dynamic> jsonList){
      List<User> list = [];
      for (var item in jsonList) {
        User user = User.fromJson(item);
        list.add(user);
      }

      return list;
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "image": image,
        "password": password,
        "roles": roles,
        "session_token": sessionToken,
        "idrol": idrol,
        "notificationToken":notificationToken
    };
}