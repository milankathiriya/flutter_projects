import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Singleton Class
class FirebaseAuthHelper {
  FirebaseAuthHelper._();
  static final FirebaseAuthHelper authHelper =
      FirebaseAuthHelper._(); // Singleton object

  static final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> loginAnonymously() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();

    return userCredential.user!.uid;
  }

  Future<User?> registerUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
  }
}
