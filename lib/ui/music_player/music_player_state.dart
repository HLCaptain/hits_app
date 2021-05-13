import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hits_app/domain/model/track.dart';

@immutable
abstract class MusicPlayerState {
  const MusicPlayerState();
}

class Loading extends MusicPlayerState {
  static final Loading _instance = Loading._();

  factory Loading() => _instance;

  Loading._();
}

class Error extends MusicPlayerState {
  static final Error _instance = Error._();

  factory Error() => _instance;

  Error._();
}

class ContentReady extends MusicPlayerState with EquatableMixin {
  final Track track;

  ContentReady({required this.track});

  @override
  List<Object> get props => [track];
}