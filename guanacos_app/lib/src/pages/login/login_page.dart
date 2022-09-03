import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gunanacos_app/src/pages/login/login_controller.dart';

import 'package:gunanacos_app/src/widgets/background.dart';
import 'package:gunanacos_app/src/pages/login/form_login.dart';
import 'package:gunanacos_app/src/widgets/title_page.dart';

class LoginPage extends StatelessWidget {
  
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          height: 50,
          child: _textDontHaveAccount(),
          decoration: BoxDecoration(
              color: Color(0xff61481C),
              border: Border.all(color: Color(0xff61481C), width: 0.0))),
      body: Stack(
        children: [Background(), _HomeBody(), FormLogin()],
      ),
    );
  }

  Widget _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes cuenta?',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 7,
        ),
        GestureDetector(
          onTap: () => loginController.goToRegisterPage(),
          child: Text('Registrate aquí',
              style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 17)))
      ],
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //Titulos
          TitlePage()
        ],
      ),
    );
  }
}
