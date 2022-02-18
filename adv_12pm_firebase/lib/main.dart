import 'package:adv_12pm_firebase/helpers/firebase_auth_helper.dart';
import 'package:adv_12pm_firebase/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      // home: const HomePage(),
      routes: {
        '/': (context) => HomePage(),
        'dashboard': (context) => DashBoard(),
      },
      theme: ThemeData(primarySwatch: Colors.deepOrange),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController =
      TextEditingController();

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase App"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton.extended(
              heroTag: null,
              label: const Text("Login Anonymously"),
              icon: const Icon(Icons.people),
              onPressed: () async {
                String uid =
                    await FirebaseAuthHelper.authHelper.loginAnonymously();

                print("Login Successful\nUID: $uid");

                Navigator.of(context).pushReplacementNamed('dashboard');
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton.extended(
                  heroTag: null,
                  label: const Text("Register"),
                  icon: const Icon(Icons.settings),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Center(
                          child: Text("Register User"),
                        ),
                        content: Form(
                          key: _registerFormKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _emailController,
                                onSaved: (val) {
                                  setState(() {
                                    email = val!;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Email"),
                                  hintText: "Enter your email",
                                ),
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                onSaved: (val) {
                                  setState(() {
                                    password = val!;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Password"),
                                  hintText: "Enter your password",
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_registerFormKey.currentState!
                                          .validate()) {
                                        _registerFormKey.currentState!.save();

                                        print(email);
                                        print(password);

                                        try {
                                          User? user = await FirebaseAuthHelper
                                              .authHelper
                                              .registerUserWithEmailAndPassword(
                                                  email, password);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Register Successful\nEmail: ${user!.email}\nUID: ${user.uid}"),
                                              backgroundColor: Colors.green,
                                            ),
                                          );

                                          Navigator.of(context).pop();
                                        } on FirebaseAuthException catch (e) {
                                          switch (e.code) {
                                            case 'weak-password':
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Enter at least 6 char long password"),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                ),
                                              );

                                              break;
                                            case 'email-already-in-use':
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "This email id is already in use"),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                ),
                                              );

                                              break;
                                          }
                                        }

                                        _emailController.clear();
                                        _passwordController.clear();

                                        setState(() {
                                          email = "";
                                          password = "";
                                        });
                                      }
                                    },
                                    child: const Text("Register"),
                                  ),
                                  OutlinedButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      _emailController.clear();
                                      _passwordController.clear();

                                      setState(() {
                                        email = "";
                                        password = "";
                                      });

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                FloatingActionButton.extended(
                  heroTag: null,
                  label: const Text("Login"),
                  icon: const Icon(Icons.security),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Center(
                          child: Text("Login User"),
                        ),
                        content: Form(
                          key: _loginFormKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailLoginController,
                                onSaved: (val) {
                                  setState(() {
                                    email = val!;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Email"),
                                  hintText: "Enter your email",
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _passwordLoginController,
                                obscureText: true,
                                onSaved: (val) {
                                  setState(() {
                                    password = val!;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Password"),
                                  hintText: "Enter your password",
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_loginFormKey.currentState!
                                          .validate()) {
                                        _loginFormKey.currentState!.save();

                                        print(email);
                                        print(password);

                                        try {
                                          User? user = await FirebaseAuthHelper
                                              .authHelper
                                              .loginUserWithEmailAndPassword(
                                                  email, password);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Login Successful\nEmail: ${user!.email}\nUID: ${user.uid}"),
                                              backgroundColor: Colors.green,
                                            ),
                                          );

                                          Navigator.of(context).pop();

                                          Navigator.of(context)
                                              .pushReplacementNamed('dashboard',
                                                  arguments: user);
                                        } on FirebaseAuthException catch (e) {
                                          switch (e.code) {
                                            case 'user-not-found':
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "User not found with this email id"),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                ),
                                              );

                                              break;
                                            case 'wrong-password':
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Invalid Credentials..."),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                ),
                                              );

                                              break;
                                          }
                                        }

                                        _emailLoginController.clear();
                                        _passwordLoginController.clear();

                                        setState(() {
                                          email = "";
                                          password = "";
                                        });
                                      }
                                    },
                                    child: const Text("Login"),
                                  ),
                                  OutlinedButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      _emailLoginController.clear();
                                      _passwordLoginController.clear();

                                      setState(() {
                                        email = "";
                                        password = "";
                                      });

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            FloatingActionButton.extended(
              heroTag: null,
              label: const Text("Sign in with Google"),
              icon: const Icon(Icons.add_moderator),
              onPressed: () async {
                User? user =
                    await FirebaseAuthHelper.authHelper.signInWithGoogle();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Login Successful\nEmail: ${user!.email}\nUID: ${user.uid}"),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.of(context)
                    .pushReplacementNamed('dashboard', arguments: user);
              },
            ),
          ],
        ),
      ),
    );
  }
}
