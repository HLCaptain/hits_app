import 'package:floor/floor.dart';
import 'package:hits_app/data/network/model/network_format.dart';

@Entity(tableName: "tracks")
class FloorTrack {
  String? type;
  String? id;
  int? disc;
  String href;
  int? playbackSeconds;
  bool? isExplicit;
  String? name;
  @primaryKey
  String isrc;
  String? shortcut;
  String? artistName;
  String? albumName;
  String? albumId;
  String? previewURL;
  bool? isStreamable;
  String? imagePath;

  FloorTrack({
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
    this.imagePath,
  });
}
