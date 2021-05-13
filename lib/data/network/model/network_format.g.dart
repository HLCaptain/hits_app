// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkFormat _$NetworkFormatFromJson(Map<String, dynamic> json) {
  return NetworkFormat(
    json['type'] as String,
    json['bitrate'] as int,
    json['name'] as String,
    json['sampleBits'] as int,
    json['sampleRate'] as int,
  );
}

Map<String, dynamic> _$NetworkFormatToJson(NetworkFormat instance) =>
    <String, dynamic>{
      'type': instance.type,
      'bitrate': instance.bitrate,
      'name': instance.name,
      'sampleBits': instance.sampleBits,
      'sampleRate': instance.sampleRate,
    };
