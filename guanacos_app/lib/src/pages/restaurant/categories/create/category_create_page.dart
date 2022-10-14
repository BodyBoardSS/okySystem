import 'package:flutter/material.dart';
import 'package:guanacos_app/src/pages/restaurant/categories/create/form_create.dart';
import 'package:guanacos_app/src/widgets/background_app.dart';

class CategoryCreatePage extends StatelessWidget {
  const CategoryCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundApp(),
          _textTitle(),
          FormCreate()
        ] 
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
            Text('Categorias', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}