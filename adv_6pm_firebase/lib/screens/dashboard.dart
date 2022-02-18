import 'package:adv_6pm_firebase/helpers/firebase_auth_helper.dart';
import 'package:adv_6pm_firebase/helpers/firebase_rtdb_helper.dart';
import 'package:adv_6pm_firebase/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<FormState> _insertFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String name = "";
  String age = "";

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments; // UserCredential

    return Scaffold(
      drawer: MyDrawer(
        userCredential: args,
      ),
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () async {
              await FirebaseAuthHelper.authHelper.logOut();

              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.blue,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.indigo],
                ),
              ),
            ),
          ),
        ],
      ),
      // body: StreamBuilder(
      //   stream: RTDBHelper.rtdbHelper.fetchAllData(),
      //   builder: (context, AsyncSnapshot ss) {
      //     if (ss.hasError) {
      //       return Center(
      //         child: Text("${ss.error}"),
      //       );
      //     } else if (ss.hasData) {
      //       var data = ss.data.snapshot.value;
      //
      //       print(data);
      //
      //       return ListView.builder(
      //         itemCount: data.length,
      //         itemBuilder: (context, i) {
      //           return Card(
      //             elevation: 3,
      //             margin: const EdgeInsets.all(10),
      //             child: (data[i] != null)
      //                 ? ListTile(
      //                     leading: Text("${data[i]['id']}"),
      //                     title: Text("${data[i]['name']}"),
      //                     subtitle: Text("Age: ${data[i]['age']}"),
      //                     trailing: Row(
      //                       mainAxisAlignment: MainAxisAlignment.end,
      //                       mainAxisSize: MainAxisSize.min,
      //                       children: [
      //                         IconButton(
      //                           icon:
      //                               const Icon(Icons.edit, color: Colors.blue),
      //                           onPressed: () async {
      //                             await RTDBHelper.rtdbHelper
      //                                 .update(data[i]['id']);
      //                           },
      //                         ),
      //                         IconButton(
      //                           icon: const Icon(Icons.delete,
      //                               color: Colors.redAccent),
      //                           onPressed: () async {
      //                             await RTDBHelper.rtdbHelper
      //                                 .delete(data[i]['id']);
      //                           },
      //                         ),
      //                       ],
      //                     ),
      //                   )
      //                 : null,
      //           );
      //         },
      //       );
      //     }
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        label: const Text("Insert"),
        icon: const Icon(Icons.add),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Form(
                    key: _insertFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter name...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              name = val!;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Name",
                          ),
                        ),
                        TextFormField(
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter age...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              age = val!;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Age",
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      child: Text("Insert"),
                      onPressed: () async {
                        if (_insertFormKey.currentState!.validate()) {
                          _insertFormKey.currentState!.save();

                          Map<String, dynamic> data = {
                            'id': 3,
                            'name': name,
                            'age': age,
                          };

                          await RTDBHelper.rtdbHelper.insert(data['id'], data);
                        }

                        _nameController.clear();
                        _ageController.clear();

                        setState(() {
                          name = "";
                          age = "";
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    OutlinedButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        _nameController.clear();
                        _ageController.clear();

                        setState(() {
                          name = "";
                          age = "";
                        });

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
