// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreTrack _$FirestoreTrackFromJson(Map<String, dynamic> json) {
  return FirestoreTrack(
    json['type'] as String,
    json['id'] as String,
    json['disc'] as int,
    json['href'] as String,
    json['playbackSeconds'] as int,
    json['isExplicit'] as bool,
    json['name'] as String,
    json['isrc'] as String,
    json['shortcut'] as String,
    json['artistName'] as String,
    json['albumName'] as String,
    json['albumId'] as String,
    json['previewURL'] as String,
    json['isStreamable'] as bool,
    json['imagePath'] as String,
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
