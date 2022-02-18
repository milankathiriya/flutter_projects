import 'package:adv_6pm_animation/screens/explicit_animation_page.dart';
import 'package:adv_6pm_animation/screens/hero_page.dart';
import 'package:adv_6pm_animation/screens/implicit_animation_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      routes: {
        '/': (context) => const HomePage(),
        'hero_page': (context) => const HeroPage(),
        'implicit_animation_page': (context) => const ImplicitAnimationPage(),
        'explicit_animation_page': (context) => const ExplicitAnimationPage(),
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
        title: const Text("Animation App"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Implicit Animations"),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                shape: StadiumBorder(),
                padding: const EdgeInsets.all(18),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('implicit_animation_page');
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              child: Text("Explicit Animations"),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                shape: StadiumBorder(),
                padding: const EdgeInsets.all(18),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('explicit_animation_page');
              },
            ),

            // InkWell(
            //   onTap: () {
            //     Navigator.of(context).pushNamed('hero_page');
            //   },
            //   child: Hero(
            //     tag: 'a1',
            //     child: const Icon(
            //       Icons.home,
            //       color: Colors.indigo,
            //       size: 120,
            //     ),
            //     transitionOnUserGestures: true,
            //     // placeholderBuilder: (context, size, widget) {
            //     //   return const CircularProgressIndicator();
            //     // },
            //     flightShuttleBuilder: (context, an, dir, fromCtx, toCtx) {
            //       return const Icon(Icons.people, size: 100);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
