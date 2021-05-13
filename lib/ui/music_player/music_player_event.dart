import 'package:flutter/foundation.dart';

@immutable
abstract class MusicPlayerEvent {
  const MusicPlayerEvent();
}

class LoadTrackEvent extends MusicPlayerEvent {
  final String id;

  LoadTrackEvent(this.id);
}
