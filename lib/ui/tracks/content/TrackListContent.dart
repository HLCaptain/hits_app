import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hits_app/ui/track_card/TrackCard.dart';

import '../../../main.dart';
import '../TrackListBloc.dart';
import '../TrackListEvent.dart';
import '../TrackListState.dart';

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
                currentTrack = track.id!;
                Navigator.pushNamed(
                  context,
                  MUSIC_PLAYER_PAGE,
                  arguments: track.id,
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
