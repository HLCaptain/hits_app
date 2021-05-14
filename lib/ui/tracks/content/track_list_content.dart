import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
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
          itemCount: state.tracks.length,
          itemBuilder: (context, index) {
            final item = state.tracks[index];
            return InkWell(
              onTap: () {
                currentTrack = item.id!;
                Navigator.pushNamed(
                  context,
                  MUSIC_PLAYER_PAGE,
                  arguments: item.id,
                );
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(12, 4, 12, 4),
                padding: EdgeInsets.zero,
                //height: 72,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  //color: Color.fromARGB(255, 240, 240, 240),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: ListTile(
                    minVerticalPadding: 0,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: item.imagePath != null
                            ? CachedNetworkImage(
                                imageUrl: item.imagePath!,
                                height: 72,
                                width: 72,
                              )
                            : Icon(
                                Icons.image,
                                size: 80,
                              ),
                      ),
                    ),
                    title: Text(
                      item.name!,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                item.artistName!,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chevron_right,
                          size: 20,
                        ),
                        // Icon(
                        //   Icons.access_time_rounded,
                        //   size: 15,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            (item.playbackSeconds! / 60).floor().toString() +
                                ":" +
                                ((item.playbackSeconds! % 60 < 10)
                                        ? ("0" +
                                            (item.playbackSeconds! % 60)
                                                .toString())
                                        : item.playbackSeconds! % 60)
                                    .toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            );
          },
        ),
      ),
    );
  }
}
