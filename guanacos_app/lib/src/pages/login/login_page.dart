import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gunanacos_app/src/pages/login/login_controller.dart';

import 'package:gunanacos_app/src/widgets/background.dart';
import 'package:gunanacos_app/src/pages/login/form_login.dart';
import 'package:gunanacos_app/src/widgets/title_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  
  LoginController loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          height: 50,
          decoration: BoxDecoration(
              color:const Color(0xff61481C),
              border: Border.all(color:const Color(0xff61481C), width: 0.0)),
          child: _textDontHaveAccount()),
      body: Stack(
        children: [const Background(), _HomeBody(), FormLogin()],
      ),
    );
  }

  Widget _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'No tienes cuenta?',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 7,
        ),
        GestureDetector(
          onTap: () => loginController.goToRegisterPage(),
          child:const Text('Registrate aquí',
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
    return Column(
      children: const [
        //Titulos
        TitlePage()
      ],
    );
  }
}
