import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guanacos_app/src/pages/home/home_controller.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomeController hController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: ()=> hController.logOut(),
          child:const Text('Salir'),
        ),
      ),
    );
  }
}
