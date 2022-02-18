import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:adv_12pm_firebase/helpers/firebase_auth_helper.dart';
import 'package:adv_12pm_firebase/helpers/firebase_rtdb_helper.dart';
import 'package:adv_12pm_firebase/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final ImagePicker _picker = ImagePicker();
  File? img;
  XFile? ximg;

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      drawer: MyDrawer(
        user: args,
      ),
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.power_settings_new,
            ),
            onPressed: () async {
              await FirebaseAuthHelper.authHelper.logOut();

              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: RTDBHelper.rtdbHelper.fetchAllData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            Map res = snapshot.data.snapshot.value;

            List items = [];

            res.forEach((key, val) {
              items.add({"key": key, ...val});
              // items.add({"key": key, "id": val['id'], "name": val['name'], "age": val['age']});
            });

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 3,
                  child: ListTile(
                    isThreeLine: true,
                    leading: fetchProfilePic(items[i]),
                    // leading: Text(items[i]['id'].toString()),
                    title: Text(items[i]['name']),
                    subtitle: Text(
                        "Age: ${items[i]['age']}\nKey: ${items[i]['key']}"),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            Map<String, dynamic> newData = {
                              'name': 'Darshan Haribhagat'
                            };

                            await RTDBHelper.rtdbHelper
                                .update(items[i]['key'], newData);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () async {
                            await RTDBHelper.rtdbHelper.delete(items[i]['key']);
                          },
                        ),
                      ],
                    ),
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: null,
            label: const Text("Insert"),
            icon: const Icon(Icons.add),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Center(
                    child: Text("Pick Image"),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        child: const CircleAvatar(radius: 60),
                        onTap: () async {
                          XFile? xfile = await _picker.pickImage(
                              source: ImageSource.camera);

                          File file = File(xfile!.path);

                          setState(() {
                            img = file;
                            ximg = xfile;
                          });

                          int uid = DateTime.now().millisecond;
                          Uint8List uint8ListImage = await ximg!.readAsBytes();

                          String base64File = base64Encode(uint8ListImage);

                          Map data = {
                            'id': 10,
                            'name': 'ZZZZZZZZ',
                            'age': 20,
                            'image': base64File,
                          };

                          RTDBHelper.rtdbHelper.insert(uid, data);

                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget fetchProfilePic(Map data) {
    String? img = data['image'];

    Uint8List memory_img = (img != null) ? base64Decode(img) : Uint8List(0);

    return (data['image'] != null)
        ? CircleAvatar(
            backgroundImage: MemoryImage(memory_img),
          )
        : Text(data['id'].toString());
  }
}
