import 'package:adv_12pm_sqlite_db_app/helpers/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'models/student_model.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final GlobalKey<FormState> _insertFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _nameUpdateController = TextEditingController();
  final TextEditingController _ageUpdateController = TextEditingController();

  String name = "";
  int age = 0;

  late Future<List<Student>> getAllData;

  TextStyle listTileTextStyle = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  final ImagePicker _picker = ImagePicker();
  var img;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    getAllData = DBHelper.dbHelper.fetchAllData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("AppLifecycleState: $state");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BG
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.indigo,
                ],
              ),
            ),
          ),
          // AppBar
          Container(
            margin: const EdgeInsets.only(top: 60),
            height: MediaQuery.of(context).size.height * 0.085,
            alignment: Alignment.center,
            color: Colors.white.withOpacity(0.2),
            child: Text(
              "SQLite App",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          // Body
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.16),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CupertinoSearchTextField(
                  onChanged: (val) {
                    setState(() {
                      getAllData = DBHelper.dbHelper.search(val);
                    });
                  },
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              FutureBuilder(
                  future: getAllData,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      List<Student> data = snapshot.data;

                      return Flexible(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            return Card(
                              margin: const EdgeInsets.all(8),
                              elevation: 3,
                              color: Colors.white.withOpacity(0.2),
                              shadowColor: Colors.white.withOpacity(0.2),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: MemoryImage(data[i].image!),
                                  radius: 35,
                                  child: Text(
                                    data[i].id.toString(),
                                    style: listTileTextStyle,
                                  ),
                                ),
                                title: Text(
                                  data[i].name,
                                  style: listTileTextStyle,
                                ),
                                subtitle: Text(
                                  "Age: " + data[i].age.toString(),
                                  style: listTileTextStyle,
                                ),
                                trailing: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        validateAndUpdate(data[i]);
                                      },
                                    ),
                                    IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          verifyAndDelete(data[i].id);
                                        }),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          "Insert",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.white.withOpacity(0.3),
        elevation: 0,
        onPressed: validateAndInsert,
      ),
    );
  }

  void validateAndInsert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Insert Record"),
            content: Form(
              key: _insertFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            (img != null) ? MemoryImage(img) : null,
                      ),
                      onTap: () async {
                        XFile? xfile =
                            await _picker.pickImage(source: ImageSource.camera);

                        var image = await xfile!.readAsBytes();

                        setState(() {
                          img = image;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your name first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          name = val!;
                        });
                      },
                      decoration: const InputDecoration(
                        label: Text("Name"),
                        hintText: "Enter your name here...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _ageController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your age first";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          age = int.parse(val!);
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Age"),
                        hintText: "Enter your age here...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                child: const Text("Insert"),
                onPressed: () async {
                  if (_insertFormKey.currentState!.validate()) {
                    _insertFormKey.currentState!.save();

                    Student student = Student(name: name, age: age, image: img);

                    int id = await DBHelper.dbHelper.insert(student);

                    _nameController.clear();
                    _ageController.clear();

                    setState(() {
                      name = "";
                      age = 0;
                      img = null;
                      getAllData = DBHelper.dbHelper.fetchAllData();
                    });

                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text("Record inserted successfully with id: $id"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
              ),
              OutlinedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  setState(() {
                    img = null;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void validateAndUpdate(Student student) {
    _nameUpdateController.text = student.name;
    _ageUpdateController.text = student.age.toString();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Record"),
            content: Form(
              key: _updateFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameUpdateController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter your name first";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      setState(() {
                        name = val!;
                      });
                    },
                    decoration: const InputDecoration(
                      label: Text("Name"),
                      hintText: "Enter your name here...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _ageUpdateController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter your age first";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      setState(() {
                        age = int.parse(val!);
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Age"),
                      hintText: "Enter your age here...",
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

                    Student updatedStudent =
                        Student(name: name, age: age, image: img);

                    int updatedId = await DBHelper.dbHelper
                        .update(student.id, updatedStudent);

                    _nameUpdateController.clear();
                    _ageUpdateController.clear();

                    setState(() {
                      name = "";
                      age = 0;
                      img = null;
                      getAllData = DBHelper.dbHelper.fetchAllData();
                    });

                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Record updated successfully with id: ${student.id}"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
              ),
              OutlinedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  setState(() {
                    img = null;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void verifyAndDelete(int? id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text("Delete Record"),
        ),
        content: const Text("Do you really want to delete this record?"),
        actions: [
          ElevatedButton(
            child: const Text("Delete"),
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              onPrimary: Colors.white,
            ),
            onPressed: () async {
              int resId = await DBHelper.dbHelper.delete(id);

              Navigator.of(context).pop();

              setState(() {
                getAllData = DBHelper.dbHelper.fetchAllData();
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Record deleted successfully with id: $id"),
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
