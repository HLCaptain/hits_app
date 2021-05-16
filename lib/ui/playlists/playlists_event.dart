import 'package:flutter/foundation.dart';

@immutable
abstract class PlaylistsEvent {
  const PlaylistsEvent();
}

class LoadTracksEvent extends PlaylistsEvent {
  static final LoadTracksEvent _instance = LoadTracksEvent._();

  factory LoadTracksEvent() => _instance;

  LoadTracksEvent._();
}

class RefreshTracksEvent extends PlaylistsEvent {
  static final RefreshTracksEvent _instance = RefreshTracksEvent._();

  factory RefreshTracksEvent() => _instance;

  RefreshTracksEvent._();
}