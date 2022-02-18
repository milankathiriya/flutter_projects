import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FontAwesomePage extends StatefulWidget {
  const FontAwesomePage({Key? key}) : super(key: key);

  @override
  _FontAwesomePageState createState() => _FontAwesomePageState();
}

class _FontAwesomePageState extends State<FontAwesomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people, size: 100),
            FaIcon(FontAwesomeIcons.bus, size: 100, color: Colors.redAccent),
            FaIcon(FontAwesomeIcons.bus, size: 100, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
