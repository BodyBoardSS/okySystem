import 'package:flutter/material.dart';

class TitlePage extends StatelessWidget {
  
  const TitlePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom:false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('GuanacosApp', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 10,),
            Text('Delicias Salvadoreñas', style: TextStyle(fontSize:16,fontWeight: FontWeight.bold, color: Colors.black))
          ],
        ),
      ),
    );
  }
}