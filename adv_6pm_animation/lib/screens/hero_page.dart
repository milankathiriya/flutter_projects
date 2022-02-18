import 'package:flutter/material.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  _HeroPageState createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Hero(
                tag: 'a1',
                child: const Icon(
                  Icons.home,
                  color: Colors.deepOrange,
                  size: 200,
                ),
                transitionOnUserGestures: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
