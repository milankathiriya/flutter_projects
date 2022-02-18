import 'dart:convert';

import 'package:adv_6pm_app/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  String API = "https://jsonplaceholder.typicode.com/posts/";

  late Future getAllPost;

  fetchAllPost() async {
    var response = await http.get(Uri.parse(API));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((e) => Post.fromJson(e)).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    getAllPost = fetchAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post List Page"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getAllPost,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error bcz of ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List data = snapshot.data;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  shadowColor: Colors.purple,
                  elevation: 6,
                  child: ListTile(
                    leading: Text("${data[i].id}"),
                    title: Text(data[i].title),
                    subtitle: Text(data[i].body),
                    trailing: Text("${data[i].userId}"),
                  ),
                );
              },
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
