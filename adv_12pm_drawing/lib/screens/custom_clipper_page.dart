import 'package:flutter/material.dart';

class CustomClipperPage extends StatefulWidget {
  const CustomClipperPage({Key? key}) : super(key: key);

  @override
  _CustomClipperPageState createState() => _CustomClipperPageState();
}

class _CustomClipperPageState extends State<CustomClipperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clipping Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                color: Colors.redAccent,
                height: 300,
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.quadraticBezierTo(
        size.width * 0.15, size.height * 0.7, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
