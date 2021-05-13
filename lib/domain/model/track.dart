import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class Track extends Equatable {
  final String? type;
  final String? id;
  final int? disc;
  final String href;
  final int? playbackSeconds;
  final bool? isExplicit;
  final String? name;
  final String isrc;
  final String? shortcut;
  final String? artistName;
  final String? albumName;
  final String? albumId;
  final String? previewURL;
  final bool? isStreamable;
  final String? imagePath;

  const Track({
    this.type,
    this.id,
    this.disc,
    required this.href,
    this.playbackSeconds,
    this.isExplicit,
    this.name,
    required this.isrc,
    this.shortcut,
    this.artistName,
    this.albumName,
    this.albumId,
    this.previewURL,
    this.isStreamable,
    this.imagePath
  });

  Track copyWith({
    String? type,
    String? id,
    int? disc,
    required String href,
    int? playbackSeconds,
    bool? isExplicit,
    String? name,
    required String isrc,
    String? shortcut,
    String? artistName,
    String? albumName,
    String? albumId,
    String? previewURL,
    bool? isStreamable,
    String? imagePath,
  }) {
    return new Track(
      type: type ?? this.type,
      id: id ?? this.id,
      disc: disc ?? this.disc,
      href: href,
      playbackSeconds: playbackSeconds ?? this.playbackSeconds,
      isExplicit: isExplicit ?? this.isExplicit,
      name: name ?? this.name,
      isrc: isrc,
      shortcut: shortcut ?? this.shortcut,
      artistName: artistName ?? this.artistName,
      albumName: albumName ?? this.albumName,
      albumId: albumId ?? this.albumId,
      previewURL: previewURL ?? this.previewURL,
      isStreamable: isStreamable ?? this.isStreamable,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => [
    type,
    id,
    disc,
    href,
    playbackSeconds,
    isExplicit,
    name,
    isrc,
    shortcut,
    artistName,
    albumName,
    albumId,
    previewURL,
    isStreamable,
    imagePath
  ];
}