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
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Hero(
                tag: 'a1',
                transitionOnUserGestures: true,
                flightShuttleBuilder:
                    (context, animation, direction, fromContext, toContext) {
                  return const Icon(
                    Icons.add_to_home_screen_sharp,
                    size: 90,
                  );
                },
                child: const Icon(
                  Icons.people,
                  size: 150,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
