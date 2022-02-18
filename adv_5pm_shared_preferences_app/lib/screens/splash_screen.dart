import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('splashScreenVisited', true);
  }

  @override
  void initState() {
    super.initState();
    checkPrefs();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('login_page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            FlutterLogo(size: 120),
            CircularProgressIndicator(),
            Text("Made with ❤️ in India"),
          ],
        ),
      ),
    );
  }
}
