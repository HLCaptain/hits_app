import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hits_app/domain/interactor/track_interactor.dart';
import 'package:hits_app/ui/tracks/TrackListEvent.dart';
import 'package:hits_app/ui/tracks/TrackListState.dart';

class TrackListBloc extends Bloc<TrackListEvent, TrackListState> {
  final TrackInteractor _trackInteractor;

  TrackListBloc(
      this._trackInteractor,
      ) : super(Loading());

  @override
  Stream<TrackListState> mapEventToState(TrackListEvent event) async* {
    if (event is LoadTracksEvent) {
      yield* _mapLoadTracksToState();
    } else if (event is RefreshTracksEvent) {
      yield* _mapRefreshTracksEvent();
    }
  }

  Stream<TrackListState> _mapLoadTracksToState() async* {
    try {
      print("Refreshing Tracks");
      await _trackInteractor.refreshTopTracks();
    } on Exception catch (e) {
      print("Refreshing Tracks failed, reason: ${e.toString()}");
      yield Error(tracks: []);
    }

    print("Getting Tracks from DB");
    final tracks = await _trackInteractor.getTopTracks();

    print("Tracks refreshed, sending Content state with Track list");
    yield ContentReady(tracks: tracks);
  }

  Stream<TrackListState> _mapRefreshTracksEvent() async* {
    final currentState = state;
    if (!(currentState is Refreshing)) {
      if (currentState is Content) {
        print("Track refreshing requested");
        yield Refreshing(tracks: currentState.tracks);

        try {
          print("Refreshing Tracks");
          await _trackInteractor.refreshTopTracks();
        } catch (e) {
          print(
              "Refreshing Tracks failed, reason: ${e.toString()}, sending Error state");
          yield Error(tracks: currentState.tracks);
        }
      }
    }

    print("Getting Tracks from DB");
    final tracks = await _trackInteractor.getTopTracks();

    yield ContentReady(tracks: tracks);
  }
}
