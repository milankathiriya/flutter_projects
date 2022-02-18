import 'package:flutter/material.dart';

class AnimationHomePage extends StatefulWidget {
  const AnimationHomePage({Key? key}) : super(key: key);

  @override
  _AnimationHomePageState createState() => _AnimationHomePageState();
}

class _AnimationHomePageState extends State<AnimationHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Home Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Implicit Animations"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(18),
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('implicit_animation_page');
              },
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('explicit_animation_page');
              },
              child: const Text("Explicit Animations"),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                padding: const EdgeInsets.all(18),
                shape: const StadiumBorder(),
              ),
            ),

            // InkWell(
            //   onTap: () {
            //     Navigator.of(context).pushNamed('hero_page');
            //   },
            //   child: const Hero(
            //     tag: 'a1',
            //     transitionOnUserGestures: true,
            //     child: Icon(
            //       Icons.people,
            //       size: 90,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
