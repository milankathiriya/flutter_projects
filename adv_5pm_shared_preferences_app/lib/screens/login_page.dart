import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _emailController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter email first...";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    email = val;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email"),
                  hintText: "Enter email here",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter password first...";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    password = val;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Password"),
                  hintText: "Enter password here",
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text("Log In"),
                onPressed: () async {
                  if (_loginFormKey.currentState!.validate()) {
                    _loginFormKey.currentState!.save();

                    if (email == 'admin@gmail.com' && password == '123456') {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      await prefs.setBool('loginPageVisited', true);

                      Navigator.of(context).pushReplacementNamed('/');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
