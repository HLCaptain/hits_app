import 'package:flutter/cupertino.dart';
import 'package:hits_app/data/disk/track_dao.dart';
import 'package:hits_app/domain/model/track.dart';
import 'model/floor_track.dart';

class TrackDiskDataSource {
  final TrackDao _trackDao;

  TrackDiskDataSource(this._trackDao);

  Future<List<Track>?> getAllTracks() async {
    try {
      final tracksFromDb = await _trackDao.getAllTracks();
      return tracksFromDb.map(
            (track) => track.toDomainModel(),
      ).toList();
    } catch (err) {
      return null;
    }
  }

  Future<Track?> getTrack(String id) async {
    try {
      final trackFromDb = await _trackDao.getTrack(id);
      return trackFromDb?.toDomainModel();
    } catch (err) {
      return null;
    }
  }

  Future<void> saveTracks(List<Track> tracks) async {
    await _trackDao.deleteAllTracks();
    _trackDao.insertTracks(
      tracks.map(
            (track) => track.toDatabaseModel(),
      ).toList(),
    );
  }
}

extension on FloorTrack {
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

extension on Track {
  FloorTrack toDatabaseModel() {
    return FloorTrack(
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