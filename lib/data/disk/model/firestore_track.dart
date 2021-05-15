import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'firestore_track.g.dart';

@immutable
@JsonSerializable()
class FirestoreTrack {
  final String type;
  final String id;
  final int disc;
  final String href;
  final int playbackSeconds;
  final bool isExplicit;
  final String name;
  final String isrc;
  final String shortcut;
  final String artistName;
  final String albumName;
  final String albumId;
  final String previewURL;
  final bool isStreamable;
  final String imagePath;

  FirestoreTrack(
    this.type,
    this.id,
    this.disc,
    this.href,
    this.playbackSeconds,
    this.isExplicit,
    this.name,
    this.isrc,
    this.shortcut,
    this.artistName,
    this.albumName,
    this.albumId,
    this.previewURL,
    this.isStreamable,
    this.imagePath,
  );

  static const fromJsonFactory = _$FirestoreTrackFromJson;

  factory FirestoreTrack.fromJson(Map<String, dynamic> json) => _$FirestoreTrackFromJson(json);

  Map<String, dynamic> toJson() => _$FirestoreTrackToJson(this);
}
