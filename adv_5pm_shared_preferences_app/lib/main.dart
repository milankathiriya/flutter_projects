import 'package:adv_5pm_shared_preferences_app/screens/login_page.dart';
import 'package:adv_5pm_shared_preferences_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool splashScreenVisited = prefs.getBool('splashScreenVisited') ?? false;
  await prefs.setBool('splashScreenVisited', splashScreenVisited);

  bool loginPageVisited = prefs.getBool('loginPageVisited') ?? false;
  await prefs.setBool('loginPageVisited', loginPageVisited);

  runApp(
    MaterialApp(
      initialRoute: (splashScreenVisited)
          ? (loginPageVisited)
              ? '/'
              : 'login_page'
          : 'splash_screen',
      routes: {
        '/': (context) => HomePage(),
        'splash_screen': (context) => SplashScreen(),
        'login_page': (context) => LoginPage(),
      },
    ),
  );
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
        title: const Text("Flutter App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              await prefs.remove('loginPageVisited');

              Navigator.of(context).pushReplacementNamed('login_page');
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
