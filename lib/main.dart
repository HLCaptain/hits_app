import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hits_app/ui/tracks/track_list.dart';
import 'package:hits_app/ui/music_player/music_player.dart';

import 'di/di_utils.dart';

void main() async {
  initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HitsApp());
}

const HOME_PAGE = "/home";
const PLAYLISTS_PAGE = "/playlists";
const MUSIC_PLAYER_PAGE = "/music_player";

class HitsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: injector.allReady(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            title: 'Hits',
            theme: ThemeData(
              primarySwatch: Colors.pink,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.teal,
              backgroundColor: Colors.black54,
            ),
            home: TrackListPage(),
            
            onGenerateRoute: (settings) {
              final name = settings.name ?? "";
              if (name.startsWith(HOME_PAGE)) {
                return MaterialPageRoute(
                  builder: (context) {
                    return MusicPlayer(settings.arguments as String);
                  },
                );
              }
              if (name.startsWith(PLAYLISTS_PAGE)) {
                return MaterialPageRoute(
                  builder: (context) {
                    return MusicPlayer(settings.arguments as String);
                  },
                );
              }
              if (name.startsWith(MUSIC_PLAYER_PAGE)) {
                return MaterialPageRoute(
                  builder: (context) {
                    return MusicPlayer(settings.arguments as String);
                  },
                );
              }
              return null;
            },
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
