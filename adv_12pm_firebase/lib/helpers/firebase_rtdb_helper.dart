import 'package:firebase_database/firebase_database.dart';

class RTDBHelper {
  RTDBHelper._();
  static final RTDBHelper rtdbHelper = RTDBHelper._();

  static final FirebaseDatabase database = FirebaseDatabase.instance;

  Future<void> insert(int uid, Map data) async {
    DatabaseReference ref = database.ref('students');
    // await ref.set(data);
    await ref.push().set(data);
    // await ref.child("$uid").set(data);
  }

  Stream fetchAllData() {
    return database.ref('students').onValue;
  }

  Future<void> delete(String key) async {
    await database.ref('students/$key').remove();
  }

  Future<void> update(String key, Map<String, dynamic> data) async {
    await database.ref('students/$key').update(data);
  }
}
