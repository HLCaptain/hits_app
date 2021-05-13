import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'network_format.dart';

part 'network_track.g.dart';

@immutable
@JsonSerializable()
class NetworkTrack {
  final String type;
  final String id;
  final int index;
  final int disc;
  final String href;
  final int playbackSeconds;
  final bool isExplicit;
  final String name;
  final String isrc;
  final String shortcut;
  final List<String> blurbs;
  final String artistName;
  final String albumName;
  final String albumId;
  final List<NetworkFormat> formats;
  final List<NetworkFormat> losslessFormats;
  //final List<Map<String, String>> contributors;
  final String previewURL;
  final bool isStreamable;
  //final List<Map<String, String>> links;

  NetworkTrack(
      this.type,
      this.id,
      this.index,
      this.disc,
      this.href,
      this.playbackSeconds,
      this.isExplicit,
      this.name,
      this.isrc,
      this.shortcut,
      this.blurbs,
      this.artistName,
      this.albumName,
      this.albumId,
      this.formats,
      this.losslessFormats,
      //this.contributors,
      this.previewURL,
      this.isStreamable,
      //this.links
      );

  static const fromJsonFactory = _$NetworkTrackFromJson;

  factory NetworkTrack.fromJson(Map<String, dynamic> json) => _$NetworkTrackFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkTrackToJson(this);
}