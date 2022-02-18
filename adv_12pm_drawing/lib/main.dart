import 'package:adv_12pm_drawing/screens/custom_clipper_page.dart';
import 'package:adv_12pm_drawing/screens/custom_painter_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      // home: HomePage(),
      routes: {
        '/': (context) => const HomePage(),
        'custom_painter_page': (context) => const CustomPainterPage(),
        'custom_clipper_page': (context) => const CustomClipperPage(),
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
              child: const Text("CustomPainter"),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                primary: Colors.indigo,
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('custom_painter_page');
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              child: const Text("CustomClipper"),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                primary: Colors.purple,
                padding: const EdgeInsets.all(20),
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
