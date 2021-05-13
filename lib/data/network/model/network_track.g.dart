// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkTrack _$NetworkTrackFromJson(Map<String, dynamic> json) {
  return NetworkTrack(
    json['type'] as String,
    json['id'] as String,
    json['index'] as int,
    json['disc'] as int,
    json['href'] as String,
    json['playbackSeconds'] as int,
    json['isExplicit'] as bool,
    json['name'] as String,
    json['isrc'] as String,
    json['shortcut'] as String,
    (json['blurbs'] as List<dynamic>).map((e) => e as String).toList(),
    json['artistName'] as String,
    json['albumName'] as String,
    json['albumId'] as String,
    (json['formats'] as List<dynamic>)
        .map((e) => NetworkFormat.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['losslessFormats'] as List<dynamic>)
        .map((e) => NetworkFormat.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['previewURL'] as String,
    json['isStreamable'] as bool,
  );
}

Map<String, dynamic> _$NetworkTrackToJson(NetworkTrack instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'index': instance.index,
      'disc': instance.disc,
      'href': instance.href,
      'playbackSeconds': instance.playbackSeconds,
      'isExplicit': instance.isExplicit,
      'name': instance.name,
      'isrc': instance.isrc,
      'shortcut': instance.shortcut,
      'blurbs': instance.blurbs,
      'artistName': instance.artistName,
      'albumName': instance.albumName,
      'albumId': instance.albumId,
      'formats': instance.formats,
      'losslessFormats': instance.losslessFormats,
      'previewURL': instance.previewURL,
      'isStreamable': instance.isStreamable,
    };
