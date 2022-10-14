import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/models/rol.dart';
import 'package:guanacos_app/src/pages/roles/roles_contoller.dart';
import 'package:guanacos_app/src/widgets/background_app.dart';

// ignore: must_be_immutable
class RolesPage extends StatelessWidget {
  

  RolesController rolesController = Get.put(RolesController());

  RolesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          const BackgroundApp(),
          _textTitle(),
          Container(
            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.12),
            child: ListView(
              children: rolesController.user.roles != null ? rolesController.user.roles!.map((Rol rol){
                return _cardRol(rol);
              }).toList() : []
            ),
          )
        ] ,
      ),
    );
  }

  Widget _textTitle(){
    return SafeArea(
      bottom:false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Seleccione un rol', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
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
            margin:const EdgeInsets.only(bottom: 15, top: 50),
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
