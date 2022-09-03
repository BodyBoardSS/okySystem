import 'package:flutter/material.dart';

import '../../widgets/background.dart';
import 'form_register.dart';

class RegisterPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Background(),
      imageUser(),
      buttonBack(),
      FormRegister()
    ]));
  }
}
