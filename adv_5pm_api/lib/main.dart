import 'dart:convert';

import 'package:adv_5pm_api/models/album_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    const MaterialApp(
      home: HomePage(),
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

    BASE_URL => https://jsonplaceholder.typicode.com/

    ENDPOINT => /posts
             => /comments

    API => https://jsonplaceholder.typicode.com/posts/


    ENCODE => MAP to JSON
    DECODE => JSON to MAP/String/List
  */

  Future<List<Album>?> fetchData() async {
    String API = "https://jsonplaceholder.typicode.com/photos/";

    http.Response res = await http.get(Uri.parse(API));

    if (res.statusCode == 200) {
      List<dynamic> data = jsonDecode(res.body);
      return data.map((e) => Album.fromJson(e)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API App"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<Album>? data = snapshot.data;

            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, i) {
                return Card(
                  margin: const EdgeInsets.all(12),
                  elevation: 4,
                  shadowColor: Colors.purple,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${data[i].thumbnailUrl}"),
                    ),
                    trailing: Text("${data[i].albumId}"),
                    title: Text("${data[i].title}"),
                    subtitle: Text("${data[i].id}"),
                  ),
                );
              },
            );
          }
          return const Center(
            child: SpinKitFadingCube(
              color: Colors.blue,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}
