import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final ImagePicker _picker = ImagePicker();
  File? _image;

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            (_image != null)
                ? Image.file(_image!)
                : const Center(
                    child: SelectableText("No image selected yet..."),
                  ),
            FloatingActionButton.extended(
              label: const Text("Open Camera"),
              icon: const Icon(Icons.camera),
              onPressed: () async {
                XFile? img =
                    await _picker.pickImage(source: ImageSource.camera);

                setState(() {
                  _image = File(img!.path);
                });
              },
            ),
            ElevatedButton(
              child: const Text("Open Website"),
              onPressed: () async {
                String url = "https://www.google.co.in";

                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
            ElevatedButton(
              child: const Text("Mail to..."),
              onPressed: () async {
                String url =
                    "mailto:darshanhirapara237@gmail.com?subject=Test&body=dummy_content";

                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
            ElevatedButton(
              child: const Text("SMS to..."),
              onPressed: () async {
                String url = "sms:9081787579";

                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
            ElevatedButton(
              child: const Text("Call to..."),
              onPressed: () async {
                String url = "tel:+919081787579";

                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
            ElevatedButton(
              child: const Text("SHARE Content"),
              onPressed: () {
                Share.share("Nothing is impossible.");
              },
            ),
          ],
        ),
      ),
    );
  }
}
