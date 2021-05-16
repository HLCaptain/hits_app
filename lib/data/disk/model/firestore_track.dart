import 'package:flutter/foundation.dart';
import 'package:hits_app/domain/model/track.dart';
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
  final DateTime insertDate;

  FirestoreTrack({
    required this.type,
    required this.id,
    required this.disc,
    required this.href,
    required this.playbackSeconds,
    required this.isExplicit,
    required this.name,
    required this.isrc,
    required this.shortcut,
    required this.artistName,
    required this.albumName,
    required this.albumId,
    required this.previewURL,
    required this.isStreamable,
    required this.imagePath,
    required this.insertDate
  });

  static const fromJsonFactory = _$FirestoreTrackFromJson;

  factory FirestoreTrack.fromJson(Map<String, dynamic> json) => _$FirestoreTrackFromJson(json);

  Map<String, dynamic> toJson() => _$FirestoreTrackToJson(this);

  Track toDomainModel() {
    return Track(
      type: this.type,
      id: this.id,
      disc: this.disc,
      href: this.href,
      playbackSeconds: this.playbackSeconds,
      isExplicit: this.isExplicit,
      name: this.name,
      isrc: isrc,
      shortcut: this.shortcut,
      artistName: this.artistName,
      albumName: this.albumName,
      albumId: this.albumId,
      previewURL: this.previewURL,
      isStreamable: this.isStreamable,
      imagePath: this.imagePath,
    );
  }
}
