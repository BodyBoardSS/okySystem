import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoDataWidget extends StatelessWidget {

  String text = '';

  // ignore: use_key_in_widget_constructors
  NoDataWidget({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/img/no_items.png',
          height: 150,
          width: 150,
        ),
        const SizedBox(height: 15,),
        Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ]
    );
  }
}