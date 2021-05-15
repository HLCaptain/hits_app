import 'package:flutter/material.dart';
import 'package:hits_app/ui/menus/PageMenu.dart';
import 'package:hits_app/ui/music_player/MusicPlayer.dart';
import 'package:hits_app/ui/playlists/playlists.dart';
import 'package:hits_app/ui/profile/profile.dart';
import 'package:hits_app/ui/tracks/content/TrackListContent.dart';
import 'package:hits_app/ui/tracks/TrackList.dart';

const PROFILE_PAGE = "/profile";
const DEFAULT_PAGE = "/";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageMenu _pageMenu = new PageMenu();



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
      home: _pageMenu,
      onGenerateRoute: (settings) {
        Widget widget = _pageMenu;
        final name = settings.name ?? "";
        if (name.startsWith(PROFILE_PAGE)) {
          widget = ProfilePage();
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
            return _pageMenu;
          }
        );
      }
    );
  }
}
