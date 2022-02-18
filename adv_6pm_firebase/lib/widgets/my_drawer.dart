import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  UserCredential? userCredential;

  MyDrawer({this.userCredential});

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
              radius: 80,
              backgroundImage: (widget.userCredential != null)
                  ? NetworkImage("${widget.userCredential!.user!.photoURL}")
                  : null,
            ),
          ),
          (widget.userCredential != null)
              ? Text(
                  "Display Name: ${widget.userCredential!.user!.displayName}")
              : Text("No display name"),
          (widget.userCredential != null)
              ? Text("Email: ${widget.userCredential!.user!.email}")
              : Text("No email"),
        ],
      ),
    );
  }
}
