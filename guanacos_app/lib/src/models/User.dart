import 'dart:convert';

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

    User({
        this.id,
        this.name,
        this.lastName,
        this.email,
        this.phone,
        this.image,
        this.password,
        this.idrol
    });


    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "image": image,
        "password": password,
        "idrol":idrol
    };
}
