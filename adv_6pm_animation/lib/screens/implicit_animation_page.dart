import 'dart:math';

import 'package:flutter/material.dart';

class ImplicitAnimationPage extends StatefulWidget {
  const ImplicitAnimationPage({Key? key}) : super(key: key);

  @override
  _ImplicitAnimationPageState createState() => _ImplicitAnimationPageState();
}

class _ImplicitAnimationPageState extends State<ImplicitAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animation Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 3500),
              tween: Tween<double>(begin: 0, end: 350),
              builder: (context, double offsetVal, widget) {
                return Transform.translate(
                  offset: Offset(0, offsetVal),
                  child: TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 3500),
                    tween: Tween<double>(begin: 0, end: pi * 2),
                    builder: (context, double val, widget) {
                      return Transform.rotate(
                        angle: val,
                        child: TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 3500),
                          tween:
                              ColorTween(begin: Colors.red, end: Colors.teal),
                          builder: (context, Color? colorVal, widget) {
                            return ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  colorVal!, BlendMode.modulate),
                              child: Image.asset(
                                "assets/images/mars_logo.png",
                                height: 250,
                                width: 250,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
