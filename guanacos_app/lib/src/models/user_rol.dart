class UserRol {
  DateTime? createdAt;
  DateTime? updatedAt;
  int? idrol;
  int? iduser;

  UserRol({
    this.createdAt,
    this.updatedAt,
    this.idrol,
    this.iduser,
  });

  factory UserRol.fromJson(Map<String, dynamic> json) => UserRol(
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    idrol: json["idrol"],
    iduser: json["iduser"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "idrol": idrol,
    "iduser": iduser,
  };
}