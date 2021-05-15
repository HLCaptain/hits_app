import 'package:flutter/material.dart';
import 'package:hits_app/ui/music_player/MusicPlayer.dart';
import 'package:hits_app/ui/playlists/playlists.dart';
import 'package:hits_app/ui/tracks/content/TrackListContent.dart';
import 'package:hits_app/ui/tracks/TrackList.dart';

import '../../main.dart';

class PageMenu extends StatefulWidget {
  const PageMenu({Key? key}) : super(key: key);

  @override
  _PageMenuState createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {
  int _currentBarIndex = 0;
  PageController _pageController = new PageController(
    initialPage: 0,
    keepPage: true,
  );
  PageView _pageView = new PageView();
  List<Widget> _screens = [
    TrackListPage(key: GlobalKey()),
    PlaylistsPage(key: GlobalKey()),
    MusicPlayer(currentTrack, key: GlobalKey()),
  ];

  _PageMenuState() {
    _pageView = new PageView(
      controller: _pageController,
      children: _screens,
      onPageChanged: _onPageChanged,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  void _tapItem(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeOutCubic,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, PROFILE_PAGE, arguments: "");
              },
              icon: Icon(
                  Icons.person
              )
          )
        ],
      ),
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
    );
  }
}
