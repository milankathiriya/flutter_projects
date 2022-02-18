import 'dart:math';

import 'package:flutter/material.dart';

class ImplicitAnimationPage extends StatefulWidget {
  const ImplicitAnimationPage({Key? key}) : super(key: key);

  @override
  _ImplicitAnimationPageState createState() => _ImplicitAnimationPageState();
}

class _ImplicitAnimationPageState extends State<ImplicitAnimationPage> {
  double _height = 250;
  double _width = 250;
  double _opacity = 1;
  double _radius = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animation Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1800),
              tween: Tween<double>(begin: 0, end: pi * 2),
              builder: (context, double? val, widget) {
                return Transform.rotate(
                  angle: val!,
                  child: TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 1800),
                    tween: ColorTween(begin: Colors.white, end: Colors.red),
                    builder: (context, Color? colorVal, widget) {
                      return ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(colorVal!, BlendMode.modulate),
                        child: Image.asset("assets/images/mars.png"),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
