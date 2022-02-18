import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  User? user;

  MyDrawer({this.user});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: CircleAvatar(
              radius: 85,
              backgroundImage: (widget.user) != null
                  ? (widget.user!.photoURL) != null
                      ? NetworkImage(widget.user!.photoURL.toString())
                      : NetworkImage(
                          "https://www.headshotsprague.com/wp-content/uploads/2019/07/Headshots_Prague-emotional-portrait-of-a-smiling-entrepreneur-1.jpg")
                  : NetworkImage(
                      "https://www.headshotsprague.com/wp-content/uploads/2019/07/Headshots_Prague-emotional-portrait-of-a-smiling-entrepreneur-1.jpg"),
            ),
          ),
          (widget.user) != null
              ? Text("Display Name: ${widget.user!.displayName}")
              : Text("Display Name: --"),
          (widget.user) != null
              ? Text("Email: ${widget.user!.email}")
              : Text("Email: --"),
        ],
      ),
    );
  }
}
