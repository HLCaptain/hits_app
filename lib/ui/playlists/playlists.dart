import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hits_app/di/di_utils.dart';
import 'package:hits_app/ui/music_player/music_player.dart';
import 'package:hits_app/ui/playlists/playlists_bloc.dart';
import 'package:hits_app/ui/playlists/playlists_event.dart';
import 'package:hits_app/ui/playlists/playlists_state.dart';
import 'package:hits_app/utils.dart';

import '../../main.dart';
import 'content/playlists_content.dart';

class PlaylistsPage extends StatefulWidget {
  const PlaylistsPage({Key? key}) : super(key: key);

  @override
  _PlaylistsPageState createState() => _PlaylistsPageState();
}

class _PlaylistsPageState extends State<PlaylistsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      onGenerateRoute: (settings) {
        final name = settings.name ?? "";
        if (name.startsWith(MUSIC_PLAYER_PAGE)) {
          return MaterialPageRoute(
            builder: (context) {
              return MusicPlayer(key: GlobalKey());
            }
          );
        }
      },
      home: Scaffold(
        body: BlocProvider(
          create: (context) => injector<PlaylistsBloc>(),
          child: BlocListener<PlaylistsBloc, PlaylistsState>(
            listener: (context, state) {
              if (state is Error) {
                context.showSnackBar(
                  content: Text("Failed to refresh tracks!"),
                );
              }
            },
            child: BlocBuilder<PlaylistsBloc, PlaylistsState>(
              builder: (context, state) {
                if (state is Loading) {
                  BlocProvider.of<PlaylistsBloc>(context).add(
                      LoadTracksEvent());
                  return PlaylistsLoading();
                }

                if (state is Content) {
                  return PlaylistsContent(state);
                }

                return Center(
                  child: Text("Something went wrong :("),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PlaylistsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
