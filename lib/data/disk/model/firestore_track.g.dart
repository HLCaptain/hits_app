// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreTrack _$FirestoreTrackFromJson(Map<String, dynamic> json) {
  return FirestoreTrack(
    type: json['type'] as String,
    id: json['id'] as String,
    disc: json['disc'] as int,
    href: json['href'] as String,
    playbackSeconds: json['playbackSeconds'] as int,
    isExplicit: json['isExplicit'] as bool,
    name: json['name'] as String,
    isrc: json['isrc'] as String,
    shortcut: json['shortcut'] as String,
    artistName: json['artistName'] as String,
    albumName: json['albumName'] as String,
    albumId: json['albumId'] as String,
    previewURL: json['previewURL'] as String,
    isStreamable: json['isStreamable'] as bool,
    imagePath: json['imagePath'] as String,
  );
}

Map<String, dynamic> _$FirestoreTrackToJson(FirestoreTrack instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'disc': instance.disc,
      'href': instance.href,
      'playbackSeconds': instance.playbackSeconds,
      'isExplicit': instance.isExplicit,
      'name': instance.name,
      'isrc': instance.isrc,
      'shortcut': instance.shortcut,
      'artistName': instance.artistName,
      'albumName': instance.albumName,
      'albumId': instance.albumId,
      'previewURL': instance.previewURL,
      'isStreamable': instance.isStreamable,
      'imagePath': instance.imagePath,
    };
