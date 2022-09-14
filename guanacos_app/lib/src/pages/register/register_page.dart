import 'package:flutter/material.dart';

import '../../widgets/background.dart';
import 'form_register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const Background(),
      imageUser(context),
      buttonBack(),
      FormRegister()
    ]));
  }
}
