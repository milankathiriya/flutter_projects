import 'package:flutter/material.dart';

class CustomPainterPage extends StatefulWidget {
  const CustomPainterPage({Key? key}) : super(key: key);

  @override
  _CustomPainterPageState createState() => _CustomPainterPageState();
}

class _CustomPainterPageState extends State<CustomPainterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drawing Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomPaint(
              painter: MyPainter(),
              // foregroundPainter: MyPainter(),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                // color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint brush = Paint();

    brush.color = Colors.teal;
    brush.strokeWidth = 3;
    brush.style = PaintingStyle.fill;

    Path path = Path();

    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.25, size.width / 2, size.height / 2);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.75, size.width, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, brush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
