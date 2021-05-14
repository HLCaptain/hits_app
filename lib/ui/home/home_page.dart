import 'package:flutter/material.dart';
import 'package:hits_app/ui/music_player/music_player.dart';
import 'package:hits_app/ui/playlists/playlists.dart';
import 'package:hits_app/ui/tracks/content/track_list_content.dart';
import 'package:hits_app/ui/tracks/track_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({required Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBarIndex = 0;
  int _currentFakeIndex = 0;
  PageController _pageController = new PageController(
    initialPage: 0,
    keepPage: true,
  );
  List<Widget> _screens = List.filled(2, Container());
  PageView _pageView = new PageView();
  List<Widget> _allScreens = [
    TrackListPage(key: GlobalKey()),
    PlaylistsPage(key: GlobalKey()),
    MusicPlayer(currentTrack),
  ];


  _HomePageState() {
    _screens[0] = _allScreens[0];
    _screens[1] = _allScreens[1];
    _pageView = new PageView(
      controller: _pageController,
      children: _screens,
      onPageChanged: _onPageChanged,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  // helps fake screen transitions
  void updateScreens(int index) {
    // no changes made to the current screen
    if (index < _currentBarIndex && _currentFakeIndex == 1) {
      _screens[0] = _allScreens[index];
      _currentFakeIndex = 0;
      _currentBarIndex = index;
      return;
    }
    if (index > _currentBarIndex && _currentFakeIndex == 0) {
      _screens[1] = _allScreens[index];
      _currentFakeIndex = 1;
      _currentBarIndex = index;
      return;
    }
    // flipping screens
    if (index < _currentBarIndex && _currentFakeIndex == 0) {
      _screens[1] = _screens[0];
      _pageController.jumpToPage(1);
      _screens[0] = _allScreens[index];
      _currentBarIndex = index;
      return;
    }
    if (index > _currentBarIndex && _currentFakeIndex == 1) {
      _screens[0] = _screens[1];
      _pageController.jumpToPage(0);
      _screens[1] = _allScreens[index];
      _currentBarIndex = index;
      return;
    }
  }

  void _tapItem(int index) {
    updateScreens(index);
    _pageController.animateToPage(
        _currentFakeIndex,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentFakeIndex = index;
    });
  }

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
      home: Scaffold(
        body: _pageView,
        bottomNavigationBar: BottomNavigationBar(
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
          onTap: _tapItem,
        ),
      ),
    );
  }
}
