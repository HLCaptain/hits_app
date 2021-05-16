import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hits_app/data/disk/model/firestore_track.dart';
import 'package:hits_app/data/disk/track_disk_data_source.dart';
import 'package:hits_app/di/di_utils.dart';
import 'package:hits_app/domain/model/track.dart';
import 'package:hits_app/ui/track_card/track_card.dart';
import 'package:hits_app/data/disk/model/firestore_track.dart';

import '../../../main.dart';
import '../playlists_bloc.dart';
import '../playlists_event.dart';
import '../playlists_state.dart';

String currentTrack = "";

class PlaylistsContent extends StatefulWidget {
  final Content state;

  PlaylistsContent(this.state);

  @override
  _PlaylistsContentState createState() => _PlaylistsContentState(state);
}

class _PlaylistsContentState extends State<PlaylistsContent> {
  final userLikedTracks = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('liked_tracks');
  Content state;
  late Completer _refreshCompleter;

  _PlaylistsContentState(this.state);

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaylistsBloc, PlaylistsState>(
      listener: (_, state) {
        if (!(state is Refreshing)) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<PlaylistsBloc>(context).add(RefreshTracksEvent());
          return _refreshCompleter.future;
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: userLikedTracks.orderBy("insertDate", descending: true,).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(child: Text("An error occured!"),);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            final List<FirestoreTrack> tracks = List<FirestoreTrack>.from(
                snapshot.data!.docs.map((e) =>
                FirestoreTrack.fromJson(e.data() as Map<String, dynamic>)))
                .toList();

            if (tracks.isEmpty) {
              return Center(child: Text("Looks empty.."),);
            }

            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final track = tracks[index];
                return InkWell(
                  onTap: () {
                    // todo: PLAY SONG
                    print("long press detected on ${track.name}!");
                    selectedTrack = track.toDomainModel();
                  },
                  onDoubleTap: () {
                    // todo: REMOVE SONG FROM LIKED SONGS
                    print("double tap detected on ${track.name}!");
                    injector<TrackDiskDataSource>().deleteTracks(
                        List<Track>.filled(1, track.toDomainModel()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "${track.name} has been removed from liked tracks!",
                          style: Theme.of(context).textTheme.bodyText1
                        ),
                        duration: Duration(milliseconds: 1200),
                        backgroundColor: Theme.of(context).backgroundColor,
                      )
                    );
                  },
                  child: TrackCard(track: track.toDomainModel()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
