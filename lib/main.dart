import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hits_app/ui/auth/AuthPage.dart';
import 'package:hits_app/ui/menus/PageMenu.dart';
import 'package:hits_app/ui/profile/ProfilePage.dart';

import 'di/di_utils.dart';
HitsApp hitsApp = HitsApp();
void main() async {
  initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(hitsApp);
}

const MENU_PAGE = "/menu";
const AUTH_PAGE = "/auth";
const PROFILE_PAGE = "/profile";
const MUSIC_PLAYER_PAGE = "/music_player";

AuthPage authPage = new AuthPage();
PageMenu pageMenu = new PageMenu();
ProfilePage profilePage = new ProfilePage();

class HitsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: injector.allReady(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.pink,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.teal,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                colorScheme: ThemeData
                    .dark()
                    .colorScheme,
              ),
            home: authPage,
            onGenerateRoute: (settings) {
              Widget widget = Container();
              final name = settings.name ?? "";
              if (name.startsWith(AUTH_PAGE)) {
                widget = authPage;
              }
              if (name.startsWith(PROFILE_PAGE)) {
                widget = profilePage;
              }
              if (name.startsWith(MENU_PAGE)) {
                widget = pageMenu;
              }
              return MaterialPageRoute(
                builder: (context) {
                  return widget;
                }
              );
            },
            onUnknownRoute: (settings) {
              MaterialPageRoute(
                  builder: (context) {
                    return authPage;
                  }
              );
            }
          );
        }
        return Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}