import 'package:gunanacos_app/src/models/Rol.dart';

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
    );

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
    };
}