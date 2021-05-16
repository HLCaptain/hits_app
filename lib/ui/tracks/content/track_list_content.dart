import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hits_app/data/disk/track_disk_data_source.dart';
import 'package:hits_app/di/di_utils.dart';
import 'package:hits_app/domain/model/track.dart';
import 'package:hits_app/main.dart';
import 'package:hits_app/ui/playlists/playlists_bloc.dart';
import 'package:hits_app/ui/playlists/playlists_event.dart' as PlaylistEvent;
import 'package:hits_app/ui/track_card/track_card.dart';

import '../track_list_bloc.dart';
import '../track_list_event.dart';
import '../track_list_state.dart';

String currentTrack = "";

class TrackListContent extends StatefulWidget {
  final Content state;

  TrackListContent(this.state);

  @override
  _TrackListContentState createState() => _TrackListContentState(state);
}

class _TrackListContentState extends State<TrackListContent> {
  Content state;
  late Completer _refreshCompleter;

  _TrackListContentState(this.state);

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrackListBloc, TrackListState>(
      listener: (_, state) {
        if (!(state is Refreshing)) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<TrackListBloc>(context).add(RefreshTracksEvent());
          return _refreshCompleter.future;
        },
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: state.tracks.length,
          itemBuilder: (context, index) {
            final track = state.tracks[index];
            return InkWell(
              onTap: () {
                // todo: PLAY SONG
                print("long press detected on ${track.name}!");
                selectedTrack = track;
              },
              onDoubleTap: () {
                // todo: ADD SONG TO LIKED SONGS
                print("double tap detected on ${track.name}!");
                injector<TrackDiskDataSource>().saveTracks(List<Track>.filled(1, track));
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "${track.name} has been added to liked tracks!",
                          style: Theme.of(context).textTheme.bodyText1
                      ),
                      duration: Duration(milliseconds: 1200),
                      backgroundColor: Theme.of(context).backgroundColor,
                    )
                );
              },
              child: TrackCard(track: track),
            );
          },
        ),
      ),
    );
  }
}
