import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/widgets/background_app.dart';

class ProfileUpdatePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundApp(),
          _buttonBack()
        ],
      ),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.amber,
                size: 30,
              )),
        ));
  }
}
