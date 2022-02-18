import 'package:firebase_database/firebase_database.dart';

class RTDBHelper {
  RTDBHelper._();
  static final RTDBHelper rtdbHelper = RTDBHelper._();

  FirebaseDatabase database = FirebaseDatabase.instance;

  Stream fetchAllData() {
    return database.ref("users/").onValue;
  }

  insert(Map data) async {
    await database.ref("users/").push().set(data);
  }
}
