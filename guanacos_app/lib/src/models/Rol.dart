import 'user_rol.dart';

class Rol {
  int? id;
  String? rol;
  String? image;
  String? route;
  UserRol? userRol;

  Rol({
    this.id,
    this.rol,
    this.image,
    this.route,
    this.userRol,
  });

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
    id: json["id"],
    rol: json["rol"],
    image: json["image"],
    route: json["route"],
    userRol: UserRol.fromJson(json["user_rol"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rol": rol,
    "image": image,
    "route": route,
    "user_rol": userRol!.toJson(),
  };
}