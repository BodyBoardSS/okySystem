import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var boxDecoration = const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Color(0xffA47E3B),
          Color(0xff61481C),
        ]));

    return Stack(
      children: [
        const Positioned(
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
    return Transform.rotate(
      angle: -pi /5,
      child: Container(
        width: 360,
        height: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(230, 179, 37, 1),
                Color.fromRGBO(191, 151, 66,1)
              ]
          )
          ,
        ),
      ),
    );
  }
}
