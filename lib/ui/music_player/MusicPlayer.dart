import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hits_app/di/di_utils.dart';
import 'package:hits_app/ui/music_player/MusicPlayerBloc.dart';
import 'package:hits_app/ui/music_player/MusicPlayerEvent.dart';
import 'package:hits_app/ui/music_player/MusicPlayerState.dart';
import 'package:url_launcher/url_launcher.dart';

import 'MusicPlayerBloc.dart';

class MusicPlayer extends StatelessWidget {
  final String trackId;

  MusicPlayer(this.trackId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => injector<MusicPlayerBloc>(),
        child: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
          builder: (context, state) {
            if (state is Loading) {
              BlocProvider.of<MusicPlayerBloc>(context)
                  .add(LoadTrackEvent(trackId));
              return TrackDetailsLoading();
            }

            if (state is ContentReady) {
              final track = state.track;
              return Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: AppBar(
                    title: Text("Music details"),
                    primary: false,
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      track.imagePath != null
                          ? Image.network(track.imagePath!, height: 350, width: 350,)
                          : Icon(
                        Icons.image,
                        size: 350,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(track.name!),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(track.artistName!),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                (track.playbackSeconds! / 60).floor().toString()
                                    + ":"
                                    + ((track.playbackSeconds! % 60 < 10) ?
                                ("0" + (track.playbackSeconds! % 60).toString()) :
                                track.playbackSeconds! % 60).toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final url = track.previewURL!;
                          await launch(url, forceWebView: true);
                        },
                        child: Text(
                          "OPEN IN BROWSER",
                        ),
                      ),
                    ],
                  )
                ),
              );
            }

            return Center(
              child: Text(
                "Something went wrong while retrieving Track with id $trackId"
              ),
            );
          },
        )
    );
  }
}

class TrackDetailsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
