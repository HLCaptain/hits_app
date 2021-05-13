import 'package:flutter/foundation.dart';

@immutable
abstract class TrackListEvent {
  const TrackListEvent();
}

class LoadTracksEvent extends TrackListEvent {
  static final LoadTracksEvent _instance = LoadTracksEvent._();

  factory LoadTracksEvent() => _instance;

  LoadTracksEvent._();
}

class RefreshTracksEvent extends TrackListEvent {
  static final RefreshTracksEvent _instance = RefreshTracksEvent._();

  factory RefreshTracksEvent() => _instance;

  RefreshTracksEvent._();
}