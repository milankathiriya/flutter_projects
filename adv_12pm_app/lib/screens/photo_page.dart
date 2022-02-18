import 'dart:convert';

import 'package:adv_12pm_app/models/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  String api = "https://jsonplaceholder.typicode.com/photos";

  late Future getPhotos;

  fetchPhotos() async {
    http.Response res = await http.get(Uri.parse(api));

    // http.Response resp = await http.post(Uri.parse(api), body: {'key': 6768746456, 'q': "red moon"});

    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);

      List response = data.map((e) => Photo.fromJson(e)).toList();

      return response;
    }
  }

  @override
  void initState() {
    super.initState();
    getPhotos = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Page"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getPhotos,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List data = snapshot.data;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data[i].thumbnailUrl),
                    ),
                    title: Text(data[i].title),
                    subtitle: Text(data[i].url),
                    trailing: Text(data[i].id.toString()),
                  ),
                );
              },
            );
          }
          return const Center(
              child: SpinKitRotatingPlain(
            color: Colors.red,
            size: 50.0,
          ));
        },
      ),
    );
  }
}
