import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/Rol.dart';
import 'package:gunanacos_app/src/pages/roles/roles_contoller.dart';

class RolesPage extends StatelessWidget {

  RolesController rolesController = Get.put(RolesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar rol', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.2),
        child: ListView(
          children: rolesController.user.roles != null ? rolesController.user.roles!.map((Rol rol){
            return _cardRol(rol);
          }).toList() : []
        ),
      ),
    );
  }

  Widget _cardRol(Rol rol){
    return GestureDetector(
      onTap: () => rolesController.goToPageRole(rol),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
            height: 100,
            child: FadeInImage(
              image: NetworkImage(rol.image!),
              fit: BoxFit.contain,
              fadeInDuration: Duration(microseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ),
          Text(
            rol.rol ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
          )
        ],
      ),
    );
  }
}
