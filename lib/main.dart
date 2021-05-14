import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hits_app/ui/home/home_page.dart';
import 'package:hits_app/ui/tracks/content/track_list_content.dart';

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
          return HomePage(key: GlobalKey());
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
// class HitsApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: injector.allReady(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//               primarySwatch: Colors.pink,
//               visualDensity: VisualDensity.adaptivePlatformDensity,
//             ),
//             darkTheme: ThemeData(
//               primarySwatch: Colors.teal,
//               visualDensity: VisualDensity.adaptivePlatformDensity,
//               colorScheme: ThemeData.dark().colorScheme,
//             ),
//             initialRoute: HOME_PAGE,
//             onGenerateRoute: (settings) {
//               Widget widget = Scaffold();
//               final name = settings.name ?? "";
//               if (name.startsWith(HOME_PAGE)) {
//                 widget = TrackListPage();
//               }
//               if (name.startsWith(PLAYLISTS_PAGE)) {
//                 widget = MusicPlayer(settings.arguments as String);
//               }
//               if (name.startsWith(MUSIC_PLAYER_PAGE)) {
//                 widget = MusicPlayer(settings.arguments as String);
//               }
//               return MaterialPageRoute(
//                 builder: (context) {
//                   return Scaffold(
//                     bottomNavigationBar: HitsAppNavigationBar(0),
//                     body: widget,
//                   );
//                 },
//               );
//             },
//           );
//         }
//
//         return Container(
//           color: Colors.white,
//           child: Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
// }

class HitsAppNavigationBar extends StatefulWidget {
  final int currentBarIndex;
  HitsAppNavigationBar(this.currentBarIndex);

  @override
  _HitsAppNavigationBarState createState() => _HitsAppNavigationBarState(currentBarIndex);
}

class _HitsAppNavigationBarState extends State<HitsAppNavigationBar> {
  int _currentBarIndex;
  _HitsAppNavigationBarState(this._currentBarIndex);

  void _tapItem(int index) {
    setState(() {
      _currentBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //backgroundColor: Theme.of(context).backgroundColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined),
          activeIcon: Icon(Icons.analytics_rounded),
          label: "Hits",
          tooltip: "Music hits",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_awesome),
          activeIcon: Icon(Icons.auto_awesome),
          label: "Library",
          tooltip: "Library, to store your favourite playlists and musics in",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.audiotrack_outlined),
          activeIcon: Icon(Icons.audiotrack),
          label: "Music Player",
          tooltip: "Access more functionality to play your music",
        ),
      ],
      currentIndex: _currentBarIndex,
      onTap: (index) {
        _tapItem(index);
        dynamic route;
        switch(index) {
          case 0 : route = HOME_PAGE; break;
          case 1 : route = PLAYLISTS_PAGE; break;
          case 2 : route = MUSIC_PLAYER_PAGE; break;
          default: route = "/"; break;
        }
        Navigator.pushNamed(context, route, arguments: currentTrack);
      },
    );
  }
}
