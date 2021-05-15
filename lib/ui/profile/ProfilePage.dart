import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  void _logOutWithGoogle(BuildContext context) async {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        Navigator.pushNamedAndRemoveUntil(context, AUTH_PAGE, (_) => false);
      }
    });
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile data"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
              ),
              ElevatedButton(
                  onPressed: () {
                    _logOutWithGoogle(context);
                  },
                  child: Text(
                    "Log out"
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
