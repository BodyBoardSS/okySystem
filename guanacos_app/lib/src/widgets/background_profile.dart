
import 'package:flutter/material.dart';

class BackgroundProfile extends StatelessWidget {
  const BackgroundProfile({Key? key}) : super(key: key);

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
        width: 450,
        height: MediaQuery.of(context).size.height * 0.50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          gradient: const LinearGradient(
              colors: [
                Color(0xffA47E3B),
                Color(0xff61481C),
              ]
          )
          ,
        ),
      );
  }
}
