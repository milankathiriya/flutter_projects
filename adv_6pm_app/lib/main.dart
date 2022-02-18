import 'dart:convert';

import 'package:adv_6pm_app/screens/post_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'models/post_model.dart';

void main() {
  runApp(
    MaterialApp(
      // home: HomePage(),
      routes: {
        '/': (context) => HomePage(),
        'post_list_page': (context) => PostListPage(),
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
      BASE_URL = https://jsonplaceholder.typicode.com
      ENDPOINT = /posts/5
  */

  /*
      ENCODE => Map to JSON
      DECODE => JSON to Map
  * */

  String API = "https://jsonplaceholder.typicode.com/posts/12";

  late Future getPost;

  fetchData() async {
    http.Response response = await http.get(Uri.parse(API));

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      return Post.fromJson(data); // Future<Post>
    }
  }

  @override
  void initState() {
    super.initState();
    getPost = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.app_registration_sharp),
            onPressed: () {
              Navigator.of(context).pushNamed('post_list_page');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getPost,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error bcz of ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            Post data = snapshot.data;

            return Card(
              margin: const EdgeInsets.all(8),
              elevation: 6,
              child: ListTile(
                leading: Text("${data.id}"),
                title: Text(data.title),
                subtitle: Text(data.body),
                trailing: Text("${data.userId}"),
              ),
            );
          }
          return const Center(
            child: SpinKitFadingCube(
              color: Colors.red,
              size: 50.0,
            ),
          );
        },
      ),
    );
  }
}
