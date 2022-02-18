import 'package:adv_6pm_batch/helpers/firebase_rtdb_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: RTDBHelper.rtdbHelper.fetchAllData(),
        builder: (context, AsyncSnapshot ss) {
          if (ss.hasError) {
            return Center(
              child: Text("${ss.error}"),
            );
          } else if (ss.hasData) {
            Map data = ss.data.snapshot.value;

            List responses = [];

            data.forEach((key, value) {
              responses.add(value);
            });

            print(responses);

            return ListView.builder(
              itemCount: responses.length,
              itemBuilder: (context, i) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  shadowColor: Colors.purple,
                  child: ListTile(
                    leading: Text("${responses[i]['id']}"),
                    title: Text("${responses[i]['name']}"),
                    subtitle: Text("Age: ${responses[i]['age']}"),
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
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Insert"),
        icon: const Icon(Icons.add),
        onPressed: () async {
          Map data = {
            'id': 6,
            'name': 'Krupu',
            'age': 27,
          };

          await RTDBHelper.rtdbHelper.insert(data);
        },
      ),
    );
  }
}
