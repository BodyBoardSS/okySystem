import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunanacos_app/src/pages/client/address/create/form_create.dart';

import 'package:gunanacos_app/src/widgets/background_app.dart';

class ClientAddressCreatePage extends StatelessWidget {
  const ClientAddressCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundApp(),
          _iconBack(),
          const SizedBox(height: 15,),
          _textTitle(),
          FormCreate()
        ] 
      ),
    );
  }

  Widget _iconBack(){
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        child: IconButton(
          onPressed: () => Get.back(), 
          icon: const Icon(Icons.arrow_back_ios, size: 30,)
        ),
      ),
    );
  }

  Widget _textTitle(){
    return SafeArea(
      bottom:false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Direcciones', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

