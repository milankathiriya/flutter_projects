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
                height: MediaQuery.of(context).size.height * .82,
                width: MediaQuery.of(context).size.width,
                // color: Colors.grey,
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
    Paint brush = Paint()
      ..color = Colors.teal
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.fill;

    Paint brush2 = Paint()
      ..color = Colors.indigo
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    Path path = Path();

    var cx = size.width * 0.25;
    var cy = size.height * 0.65;

    var dx = size.width * 0.5;
    var dy = size.height * 0.75;

    var cx2 = size.width * 0.75;
    var cy2 = size.height * 0.85;

    var dx2 = size.width;
    var dy2 = size.height * 0.75;

    path.moveTo(0, size.height * 0.75);
    path.quadraticBezierTo(cx, cy, dx, dy);
    path.quadraticBezierTo(cx2, cy2, dx2, dy2);

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
