import 'package:hits_app/data/disk/track_dao.dart';
import 'package:hits_app/domain/model/track.dart';
import 'model/firestore_track.dart';

class TrackDiskDataSource {
  final TrackDao _trackDao;

  TrackDiskDataSource(this._trackDao);

  Future<List<Track>?> getTopTracks() async {
    try {
      final tracksFromDb = await _trackDao.getTopTracks();
      return tracksFromDb.map(
            (track) => track.toDomainModel(),
      ).toList();
    } catch (err) {
      return null;
    }
  }

  Future<List<Track>?> getLikedTracks() async {
    try {
      final tracksFromDb = await _trackDao.getLikedTracks();
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
    _trackDao.insertTracks(
      tracks.map(
            (track) => track.toDatabaseModel(),
      ).toList(),
    );
  }

  Future<void> deleteTracks(List<Track> tracks) async {
    tracks.forEach((track) {_trackDao.deleteTrack(track.id!);});
  }
}

// todo: swap to FirestoreTrack
extension on Track {
  FirestoreTrack toDatabaseModel() {
    return FirestoreTrack(
        type: this.type ?? "",
        id: this.id ?? "",
        disc: this.disc ?? 0,
        href: this.href,
        playbackSeconds: this.playbackSeconds ?? 0,
        isExplicit: this.isExplicit ?? false,
        name: this.name ?? "",
        isrc: isrc,
        shortcut: this.shortcut ?? "",
        artistName: this.artistName ?? "",
        albumName: this.albumName ?? "",
        albumId: this.albumId ?? "",
        previewURL: this.previewURL ?? "",
        isStreamable: this.isStreamable ?? false,
        imagePath: this.imagePath ?? "",
        insertDate: DateTime.now()
    );
  }
}