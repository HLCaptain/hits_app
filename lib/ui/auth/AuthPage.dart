import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hits_app/main.dart';
import 'package:hits_app/ui/login/LoginPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Conditional.single(
        context: context,
        conditionBuilder: (context) {
          return FirebaseAuth.instance.currentUser != null;
        },
        widgetBuilder: (context) => pageMenu,
        fallbackBuilder: (context) => LoginPage());
  }


}
