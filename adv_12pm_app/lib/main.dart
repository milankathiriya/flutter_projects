import 'dart:convert';

import 'package:adv_12pm_app/animation/explicit_animation_page.dart';
import 'package:adv_12pm_app/animation/hero/hero_page.dart';
import 'package:adv_12pm_app/animation/implicit_animation_page.dart';
import 'package:adv_12pm_app/screens/photo_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'animation/animation_home_page.dart';
import 'models/post_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      routes: {
        // '/': (context) => const HomePage(),
        '/': (context) => const AnimationHomePage(),
        'implicit_animation_page': (context) => const ImplicitAnimationPage(),
        'explicit_animation_page': (context) => const ExplicitAnimationPage(),
        'photo_page': (context) => const PhotoPage(),
        'hero_page': (context) => const HeroPage(),
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
  /*
      BASE_URL => https://jsonplaceholder.typicode.com
      ENDPOINT => /posts
                  /users
                  /photos
                  /albums
  * */

  /*
      Encode => Map to JSON
      Decode => JSON to Map
  * */

  String api = "https://jsonplaceholder.typicode.com/posts/3";

  late Future getPost;

  fetchPost() async {
    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map data = jsonDecode(res.body);

      return Post.fromJson(data);
    }
  }

  @override
  void initState() {
    super.initState();
    getPost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: () {
              Navigator.of(context).pushNamed('photo_page');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getPost,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            Post data = snapshot.data;

            return Card(
              elevation: 3,
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Text("${data.id}"),
                title: Text(data.title),
                subtitle: Text(data.body),
                trailing: Text("${data.userId}"),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
