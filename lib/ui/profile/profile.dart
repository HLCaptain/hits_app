import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  void _logOutWithGoogle() async {
    FirebaseAuth.instance.signOut();
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
                    _logOutWithGoogle();
                    Navigator.pushNamed(context, "/");
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
