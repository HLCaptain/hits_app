import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'network_track.dart';

part 'network_reply.g.dart';

@immutable
@JsonSerializable()
class NetworkReply {
  final List<NetworkTrack> tracks;

  NetworkReply(
    this.tracks,
  );

  static const fromJsonFactory = _$NetworkReplyFromJson;

  factory NetworkReply.fromJson(Map<String, dynamic> json) => _$NetworkReplyFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkReplyToJson(this);
}
