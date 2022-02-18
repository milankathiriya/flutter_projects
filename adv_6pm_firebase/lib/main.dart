import 'package:adv_6pm_firebase/helpers/firebase_auth_helper.dart';
import 'package:adv_6pm_firebase/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'dashboard': (context) => const Dashboard(),
      },
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
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
        title: const Text("FirebaseApp"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton.extended(
              heroTag: null,
              label: const Text("Anonymous Sign In"),
              icon: const Icon(Icons.people),
              onPressed: () async {
                String uid =
                    await FirebaseAuthHelper.authHelper.loginAnonymously();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Login Successful\nUID: $uid"),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.of(context).pushReplacementNamed('dashboard');
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton.extended(
                  heroTag: null,
                  label: const Text("Register"),
                  icon: const Icon(Icons.email),
                  onPressed: () {
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
                                  label: Text("Email"),
                                  hintText: "Enter your email here...",
                                  border: OutlineInputBorder(),
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
                                  label: Text("Password"),
                                  hintText: "Enter your password here...",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          OutlinedButton(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
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
                          ElevatedButton(
                            child: const Text("Register"),
                            onPressed: () async {
                              if (_registerFormKey.currentState!.validate()) {
                                _registerFormKey.currentState!.save();

                                try {
                                  User? user = await FirebaseAuthHelper
                                      .authHelper
                                      .registerWithEmailAndPassword(
                                          email, password);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Register Successful\nEmail: ${user!.email}\nUID: ${user.uid}"),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  switch (e.code) {
                                    case 'weak-password':
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Enter at least 6 char long password."),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                      break;
                                    case 'email-already-in-use':
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "User already exists with this email id."),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                      break;
                                  }
                                }
                              }

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
                    );
                  },
                ),
                FloatingActionButton.extended(
                  heroTag: null,
                  label: const Text("Login"),
                  icon: const Icon(Icons.security),
                  onPressed: () {
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
                                controller: _emailLoginController,
                                onSaved: (val) {
                                  setState(() {
                                    email = val!;
                                  });
                                },
                                decoration: const InputDecoration(
                                  label: Text("Email"),
                                  hintText: "Enter your email here...",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              TextFormField(
                                controller: _passwordLoginController,
                                obscureText: true,
                                onSaved: (val) {
                                  setState(() {
                                    password = val!;
                                  });
                                },
                                decoration: const InputDecoration(
                                  label: Text("Password"),
                                  hintText: "Enter your password here...",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          OutlinedButton(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
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
                          ElevatedButton(
                            child: const Text("Login"),
                            onPressed: () async {
                              if (_loginFormKey.currentState!.validate()) {
                                _loginFormKey.currentState!.save();

                                try {
                                  User? user = await FirebaseAuthHelper
                                      .authHelper
                                      .loginWithEmailAndPassword(
                                          email, password);

                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Login Successful\nEmail: ${user!.email}\nUID: ${user.uid}"),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  Navigator.of(context)
                                      .pushReplacementNamed('dashboard');
                                } on FirebaseAuthException catch (e) {
                                  switch (e.code) {
                                    case 'user-not-found':
                                      Navigator.of(context).pop();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "User does not exists with this email id."),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );

                                      break;
                                    case 'wrong-password':
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Invalid credentials..."),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );

                                      break;
                                  }
                                }
                              }

                              _emailLoginController.clear();
                              _passwordLoginController.clear();

                              setState(() {
                                email = "";
                                password = "";
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            FloatingActionButton.extended(
              heroTag: null,
              label: const Text("Sign In with Google"),
              icon: const Icon(Icons.people),
              onPressed: () async {
                UserCredential userCredential =
                    await FirebaseAuthHelper.authHelper.signInWithGoogle();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Login Successful\nEmail: ${userCredential.user!.email}\nUID: ${userCredential.user!.uid}"),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.of(context).pushReplacementNamed('dashboard',
                    arguments: userCredential);
              },
            ),
          ],
        ),
      ),

      // Container(
      //   alignment: Alignment.center,
      //   child: Stack(
      //     fit: StackFit.expand,
      //     children: [
      //       Container(
      //         height: MediaQuery.of(context).size.height,
      //         width: MediaQuery.of(context).size.width,
      //         decoration: const BoxDecoration(
      //           gradient: LinearGradient(
      //             colors: [
      //               Colors.blue,
      //               Colors.indigo,
      //             ],
      //           ),
      //         ),
      //       ),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Container(
      //             alignment: Alignment.center,
      //             child: Text(
      //               "FLUTTER",
      //               style: TextStyle(
      //                 color: Colors.white.withOpacity(0.5),
      //                 fontSize: 36,
      //                 fontWeight: FontWeight.w300,
      //                 letterSpacing: 4,
      //               ),
      //             ),
      //             decoration: BoxDecoration(
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.white.withOpacity(0.1),
      //                   offset: const Offset(15, 15),
      //                   blurRadius: 15,
      //                 ),
      //               ],
      //               border: Border.all(
      //                 color: Colors.white.withOpacity(0.15),
      //               ),
      //               borderRadius: BorderRadius.circular(0),
      //               gradient: LinearGradient(
      //                 colors: [
      //                   Colors.white.withOpacity(0.5),
      //                   Colors.grey.withOpacity(0.2),
      //                 ],
      //               ),
      //             ),
      //             height: 240,
      //             width: 350,
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
