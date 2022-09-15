
import 'package:flutter/material.dart';

class BackgroundApp extends StatelessWidget {
  const BackgroundApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Color(0xffA47E3B),
          Color(0xff61481C),
        ]),
        );

    return Stack(
      children: [
        Container( 
          decoration: boxDecoration,
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.15
          ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
              color: Colors.white
            ),
          ),
      ],
    );
  }
}