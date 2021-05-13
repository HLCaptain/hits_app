import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'network_format.g.dart';

@immutable
@JsonSerializable()
class NetworkFormat {
  final String type;
  final int bitrate;
  final String name;
  final int sampleBits;
  final int sampleRate;

  NetworkFormat(
      this.type,
      this.bitrate,
      this.name,
      this.sampleBits,
      this.sampleRate
      );

  static const fromJsonFactory = _$NetworkFormatFromJson;

  factory NetworkFormat.fromJson(Map<String, dynamic> json) => _$NetworkFormatFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkFormatToJson(this);
}