import 'package:flutter/material.dart';
import 'package:hits_app/main.dart';
import 'package:hits_app/ui/profile/ProfilePage.dart';


const DEFAULT_PAGE = "/";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
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
      home: pageMenu,
      onGenerateRoute: (settings) {
        Widget widget = pageMenu;
        final name = settings.name ?? "";
        if (name.startsWith(PROFILE_PAGE)) {
          widget = ProfilePage();
        }
        if (name.startsWith(AUTH_PAGE)) {
          return MaterialPageRoute(
              builder: (context) {
                return widget;
              }
          );
        }
        return MaterialPageRoute(
              builder: (context) {
            return widget;
          }
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return pageMenu;
          }
        );
      }
    );
  }
}
