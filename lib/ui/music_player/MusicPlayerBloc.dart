import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hits_app/domain/interactor/track_interactor.dart';
import 'MusicPlayerState.dart';
import 'package:hits_app/ui/music_player/MusicPlayerEvent.dart';
import 'package:hits_app/ui/music_player/MusicPlayerState.dart';
import 'MusicPlayerState.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final TrackInteractor _trackInteractor;

  MusicPlayerBloc(
      this._trackInteractor,
      ) : super(Loading());

  @override
  Stream<MusicPlayerState> mapEventToState(MusicPlayerEvent event) async* {
    if (event is LoadTrackEvent) {
      yield* _mapLoadTrackToState(event);
    }
  }

  Stream<MusicPlayerState> _mapLoadTrackToState(LoadTrackEvent event) async* {
    print("Fetching Track from DB with id: ${event.id}");
    final track = await _trackInteractor.getTrackById(event.id);

    if(track != null) {
      print("Track fetched, sending ContentReady state with Article");
      yield ContentReady(track: track);
    } else {
      print("Track with ID ${event.id} was not found!");
      yield Error();
    }
  }
}
