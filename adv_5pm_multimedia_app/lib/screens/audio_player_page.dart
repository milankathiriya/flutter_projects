import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({Key? key}) : super(key: key);

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  bool isPlaying = false;

  Duration? duration = const Duration(seconds: 0);
  Duration? position = const Duration(seconds: 0);

  double sliderVal = 0;

  @override
  void initState() {
    super.initState();

    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() => duration = d);
    });

    audioPlayer.onAudioPositionChanged.listen((Duration d) {
      setState(() {
        position = d;
        sliderVal = position!.inSeconds.toDouble();
      });
      print(d);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Player Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Asset Song",
              style: TextStyle(fontSize: 24),
            ),
            ListTile(
              leading: IconButton(
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                ),
                onPressed: () async {
                  audioPlayer = await audioCache.play("audio/song.mp3");

                  setState(() {
                    isPlaying = true;
                  });

                  audioPlayer.onDurationChanged.listen((Duration d) {
                    setState(() => duration = d);
                  });

                  audioPlayer.onAudioPositionChanged.listen((Duration d) {
                    setState(() {
                      position = d;
                      sliderVal = position!.inSeconds.toDouble();
                    });
                    print(d);
                  });
                },
              ),
              title: (isPlaying)
                  ? IconButton(
                      icon: const Icon(Icons.pause),
                      onPressed: () async {
                        int res = await audioPlayer.pause();
                        print("Pause: $res");

                        setState(() {
                          isPlaying = false;
                        });
                      },
                    )
                  : null,
              trailing: (isPlaying)
                  ? IconButton(
                      icon: const Icon(
                        Icons.stop,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        int res = await audioPlayer.stop();
                        print("Stop: $res");
                        setState(() {
                          isPlaying = false;
                          position = Duration(seconds: 0);
                          sliderVal = 0;
                        });
                      },
                    )
                  : null,
              onTap: () {},
              tileColor: Colors.redAccent,
            ),
            Slider(
              min: 0,
              max: duration!.inSeconds.toDouble(),
              value: sliderVal,
              onChanged: (val) async {
                setState(() {
                  sliderVal = val;
                });
                await audioPlayer.seek(Duration(seconds: val.toInt()));
              },
            ),
            Text(
              "$position / $duration",
              style: const TextStyle(fontSize: 20),
            ),

            // const Text(
            //   "Network Song",
            //   style: TextStyle(fontSize: 24),
            // ),
            // ListTile(
            //   leading: IconButton(
            //     icon: const Icon(
            //       Icons.play_arrow,
            //       color: Colors.black,
            //     ),
            //     onPressed: () async {
            //       int res = await audioPlayer
            //           .play("https://bigsoundbank.com/UPLOAD/mp3/0149.mp3");
            //       print("Play: $res");
            //
            //       setState(() {
            //         isPlaying = true;
            //       });
            //     },
            //   ),
            //   title: (isPlaying)
            //       ? IconButton(
            //           icon: const Icon(Icons.pause),
            //           onPressed: () async {
            //             int res = await audioPlayer.pause();
            //             print("Pause: $res");
            //
            //             setState(() {
            //               isPlaying = false;
            //             });
            //           },
            //         )
            //       : null,
            //   trailing: (isPlaying)
            //       ? IconButton(
            //           icon: const Icon(
            //             Icons.stop,
            //             color: Colors.black,
            //           ),
            //           onPressed: () async {
            //             int res = await audioPlayer.stop();
            //             print("Stop: $res");
            //             setState(() {
            //               isPlaying = false;
            //               position = Duration(seconds: 0);
            //               sliderVal = 0;
            //             });
            //           },
            //         )
            //       : null,
            //   onTap: () {},
            //   tileColor: Colors.amber,
            // ),
            // Slider(
            //   min: 0,
            //   max: duration!.inSeconds.toDouble(),
            //   value: sliderVal,
            //   onChanged: (val) async {
            //     setState(() {
            //       sliderVal = val;
            //     });
            //     await audioPlayer.seek(Duration(seconds: val.toInt()));
            //   },
            // ),
            // Text(
            //   "$position / $duration",
            //   style: const TextStyle(fontSize: 20),
            // ),
          ],
        ),
      ),
    );
  }
}
