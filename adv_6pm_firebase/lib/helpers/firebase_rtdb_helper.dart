import 'package:firebase_database/firebase_database.dart';

class RTDBHelper {
  RTDBHelper._();
  static final RTDBHelper rtdbHelper = RTDBHelper._();

  FirebaseDatabase database = FirebaseDatabase.instance;

  Future<void> insert(int key, Map<String, dynamic> data) async {
    DatabaseReference ref = database.ref('students/$key');

    // await ref.push().set(data);
    await ref.set(data);
  }

  Stream<DatabaseEvent> fetchAllData() {
    return database.ref('students/').onValue;
  }

  Future<void> delete(int key) async {
    DatabaseReference ref = database.ref('students/$key');
    await ref.remove();
  }

  Future<void> update(int key) async {
    DatabaseReference ref = database.ref('students/$key');
    Map<String, dynamic> newData = {
      'id': 7,
      'name': 'Krups',
      'age': 27,
    };
    await ref.update(newData);
  }
}
