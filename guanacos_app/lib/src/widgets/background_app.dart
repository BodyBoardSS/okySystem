import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundApp extends StatelessWidget {
  const BackgroundApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: const [
         Positioned(
          top: -100,
          left: -30,
          child: _Box()
        )
      ],
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(230, 179, 37, 1),
                Color.fromRGBO(191, 151, 66,1)
              ]
          )
          ,
        ),
      );
  }
}
