import 'dart:typed_data';

import 'package:adv_6pm_sqlite_app/helpers/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:image_picker/image_picker.dart';

import 'models/student_model.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _insertFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _nameUpdateController = TextEditingController();
  final TextEditingController _ageUpdateController = TextEditingController();

  String name = "";
  int age = 0;

  late Future<List<Student>> getAllData;

  final ImagePicker _picker = ImagePicker();
  Uint8List? pickedImage;

  @override
  void initState() {
    super.initState();
    getAllData = DBHelper.dbHelper.fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) async {
                  setState(() {
                    getAllData = DBHelper.dbHelper.search(val);
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Enter any name to search record",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: FutureBuilder(
              future: getAllData,
              builder: (context, AsyncSnapshot ss) {
                if (ss.hasError) {
                  return Center(child: Text("Error: ${ss.error}"));
                } else if (ss.hasData) {
                  List<Student> data = ss.data;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.all(8),
                        shadowColor: Colors.purple,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 40,
                            backgroundImage: (data[i].image != null)
                                ? MemoryImage(data[i].image!)
                                : null,
                          ),
                          // leading: Text("${i + 1}"),
                          // leading: Text(data[i].id.toString()),
                          title: Text(data[i].name),
                          subtitle: Text("Age: " + data[i].age.toString()),
                          trailing: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  validateAndUpdateData(data[i]);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  verifyAndDelete(data[i].id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Insert"),
        icon: const Icon(Icons.add),
        onPressed: validateAndInsertData,
      ),
    );
  }

  void validateAndInsertData() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text("Insert Data"),
          ),
          content: Form(
            key: _insertFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);

                    Uint8List imgList = await photo!.readAsBytes();
                    setState(() {
                      pickedImage = imgList;
                    });
                  },
                  child: CircleAvatar(
                    radius: 60,
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your name first...";
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      name = val!;
                    });
                  },
                  decoration: const InputDecoration(
                    label: Text("Name"),
                    hintText: "Enter your name here",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your age first...";
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      age = int.parse(val!);
                    });
                  },
                  decoration: const InputDecoration(
                    label: Text("Age"),
                    hintText: "Enter your age here",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text("Insert"),
              onPressed: () async {
                if (_insertFormKey.currentState!.validate()) {
                  _insertFormKey.currentState!.save();

                  Student s1 =
                      Student(name: name, age: age, image: pickedImage);

                  int insertedId = await DBHelper.dbHelper.insert(s1);

                  setState(() {
                    getAllData = DBHelper.dbHelper.fetchAllData();
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Record inserted successfully with id: $insertedId"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }

                _nameController.clear();
                _ageController.clear();

                setState(() {
                  name = "";
                  age = 0;
                  pickedImage = Uint8List(0);
                });

                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child: const Text("Cancel"),
              onPressed: () {
                _nameController.clear();
                _ageController.clear();

                setState(() {
                  name = "";
                  age = 0;
                  pickedImage = Uint8List(0);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void validateAndUpdateData(Student student) async {
    _nameUpdateController.text = student.name;
    _ageUpdateController.text = student.age.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text("Update Data"),
          ),
          content: Form(
            key: _updateFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);

                    Uint8List imgList = await photo!.readAsBytes();
                    setState(() {
                      pickedImage = imgList;
                    });
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: (student.image != null)
                        ? MemoryImage(student.image!)
                        : null,
                  ),
                ),
                TextFormField(
                  controller: _nameUpdateController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your name first...";
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      name = val!;
                    });
                  },
                  decoration: const InputDecoration(
                    label: Text("Name"),
                    hintText: "Enter your name here",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _ageUpdateController,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your age first...";
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      age = int.parse(val!);
                    });
                  },
                  decoration: const InputDecoration(
                    label: Text("Age"),
                    hintText: "Enter your age here",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text("Update"),
              onPressed: () async {
                if (_updateFormKey.currentState!.validate()) {
                  _updateFormKey.currentState!.save();

                  Student s = Student(name: name, age: age, image: pickedImage);

                  await DBHelper.dbHelper.update(s, student.id);

                  setState(() {
                    getAllData = DBHelper.dbHelper.fetchAllData();
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Record updated successfully..."),
                      backgroundColor: Colors.green,
                    ),
                  );
                }

                _nameUpdateController.clear();
                _ageUpdateController.clear();

                setState(() {
                  name = "";
                  age = 0;
                  pickedImage = Uint8List(0);
                });

                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child: const Text("Cancel"),
              onPressed: () {
                _nameUpdateController.clear();
                _ageUpdateController.clear();

                setState(() {
                  name = "";
                  age = 0;
                  pickedImage = Uint8List(0);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void verifyAndDelete(int? id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text("Delete Record"),
        ),
        content: const Text("Are you sure to delete this record?"),
        actions: [
          ElevatedButton(
            child: const Text("Delete"),
            style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            onPressed: () async {
              await DBHelper.dbHelper.delete(id!);

              Navigator.of(context).pop();

              setState(() {
                getAllData = DBHelper.dbHelper.fetchAllData();
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Record deleted successfully..."),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
          OutlinedButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
