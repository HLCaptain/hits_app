import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hits_app/di/di_utils.dart';
import 'package:hits_app/main.dart';
import 'package:hits_app/ui/music_player/music_player_bloc.dart';
import 'package:hits_app/ui/music_player/music_player_event.dart';
import 'package:hits_app/ui/music_player/music_player_state.dart';

import 'music_player_bloc.dart';

class MusicPlayer extends StatelessWidget {
  MusicPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => injector<MusicPlayerBloc>(),
        child: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
          builder: (context, state) {
            if (state is Loading) {
              if (selectedTrack != null) {
                BlocProvider.of<MusicPlayerBloc>(context)
                    .add(LoadTrackEvent(selectedTrack!.id ?? ""));
              }
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: track.imagePath != null
                              ? Image.network(track.imagePath!, height: 350, width: 350,)
                              : Icon(
                            Icons.image,
                            size: 350,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                            track.name!,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("Artist: " + track.artistName!),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("Album: " + track.albumName!),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Duration: "
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 0,0,0),
                              child: Icon(
                                Icons.access_time_rounded,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              );
            }

            return Center(
              child: Text(
                "Something went wrong while retrieving Track with id ${selectedTrack!.id}"
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
