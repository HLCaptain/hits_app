import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hits_app/domain/model/track.dart';

@immutable
abstract class PlaylistsState {
  const PlaylistsState();
}

class Loading extends PlaylistsState {
  static final Loading _instance = Loading._();

  factory Loading() => _instance;

  Loading._();
}

abstract class Content extends PlaylistsState {
  final List<Track> tracks;

  Content({required this.tracks});
}

class ContentReady extends Content with EquatableMixin {
  ContentReady({required List<Track> tracks}): super(tracks: tracks);

  @override
  List<Object> get props => [tracks];
}

class Refreshing extends Content with EquatableMixin {
  Refreshing({required List<Track> tracks}): super(tracks: tracks);

  @override
  List<Object> get props => [tracks];
}

class Error extends Content with EquatableMixin {
  Error({required List<Track> tracks}): super(tracks: tracks);

  @override
  List<Object> get props => [tracks];
}