import 'package:adv_6pm_drawing/screens/custom_clipper_page.dart';
import 'package:adv_6pm_drawing/screens/custom_painter_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        'custom_painter_page': (context) => CustomPainterPage(),
        'custom_clipper_page': (context) => CustomClipperPage(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drawing & Clipping"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("CustomPainter"),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: Colors.deepOrange,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('custom_painter_page');
              },
            ),
            ElevatedButton(
              child: Text("CustomClipper"),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: Colors.indigo,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('custom_clipper_page');
              },
            ),
          ],
        ),
      ),
    );
  }
}
