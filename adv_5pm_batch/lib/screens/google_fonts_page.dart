import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleFontsPage extends StatefulWidget {
  const GoogleFontsPage({Key? key}) : super(key: key);

  @override
  _GoogleFontsPageState createState() => _GoogleFontsPageState();
}

class _GoogleFontsPageState extends State<GoogleFontsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter is Framework",
              style: GoogleFonts.adamina(textStyle: TextStyle(fontSize: 35)),
            ),
            Text(
              "Flutter is Framework",
              style: GoogleFonts.aladin(textStyle: TextStyle(fontSize: 35)),
            ),
            Text(
              "Flutter is Framework",
              style: GoogleFonts.balooBhai(textStyle: TextStyle(fontSize: 35)),
            ),
          ],
        ),
      ),
    );
  }
}
