import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RFlutterAlertPage extends StatefulWidget {
  const RFlutterAlertPage({Key? key}) : super(key: key);

  @override
  _RFlutterAlertPageState createState() => _RFlutterAlertPageState();
}

class _RFlutterAlertPageState extends State<RFlutterAlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Simple Alert"),
              onPressed: () {
                Alert(
                  type: AlertType.success,
                  style: AlertStyle(
                    animationDuration: Duration(milliseconds: 480),
                    animationType: AnimationType.fromTop,
                  ),
                  context: context,
                  title: "Simple Alert",
                  desc: "Dummy Body",
                ).show();
              },
            ),
            ElevatedButton(
              child: Text("Alert with Buttons"),
              onPressed: () {
                Alert(
                  context: context,
                  title: "Alert with Buttons",
                  desc: "Dummy Body",
                  buttons: [
                    DialogButton(
                      child: Text("Cancel"),
                      onPressed: () {},
                    ),
                    DialogButton(
                      child: Text("OK"),
                      onPressed: () {},
                    ),
                  ],
                ).show();
              },
            ),
          ],
        ),
      ),
    );
  }
}
