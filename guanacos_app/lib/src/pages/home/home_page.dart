import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/pages/home/home_controller.dart';

class HomePage extends StatelessWidget {

  HomeController hController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: ()=> hController.logOut(),
          child: Text('Salir'),
        ),
      ),
    );
  }
}
