import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/models/Rol.dart';
import 'package:gunanacos_app/src/pages/roles/roles_contoller.dart';

// ignore: must_be_immutable
class RolesPage extends StatelessWidget {
  

  RolesController rolesController = Get.put(RolesController());

  RolesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Seleccionar rol', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.12),
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
            margin:const EdgeInsets.only(bottom: 15, top: 15),
            height: 100,
            child: FadeInImage(
              image: NetworkImage(rol.image!),
              fit: BoxFit.contain,
              fadeInDuration:const Duration(milliseconds: 50),
              placeholder:const AssetImage('assets/img/no-image.png'),
            ),
          ),
          Text(
            rol.rol ?? '',
            style:const TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
          )
        ],
      ),
    );
  }
}
