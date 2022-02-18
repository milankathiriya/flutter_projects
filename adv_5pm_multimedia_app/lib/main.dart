import 'package:adv_5pm_multimedia_app/screens/audio_player_page.dart';
import 'package:adv_5pm_multimedia_app/screens/carousel_slider_page.dart';
import 'package:adv_5pm_multimedia_app/screens/video_player_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        '/': (context) => const HomePage(),
        'audio_player_page': (context) => const AudioPlayerPage(),
        'video_player_page': (context) => const VideoPlayerPage(),
        'carousel_slider_page': (context) => const CarouselSliderPage(),
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
        title: const Text("Flutter App"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("audioplayers"),
              onPressed: () {
                Navigator.of(context).pushNamed('audio_player_page');
              },
            ),
            ElevatedButton(
              child: const Text("video_player/chewie"),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('video_player_page');
              },
            ),
            ElevatedButton(
              child: const Text("carousel_slider"),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('carousel_slider_page');
              },
            ),
          ],
        ),
      ),
    );
  }
}
