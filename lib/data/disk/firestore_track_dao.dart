import 'package:hits_app/data/disk/firestore_service.dart';
import 'package:hits_app/data/disk/model/firestore_track.dart';
import 'package:hits_app/data/disk/track_dao.dart';
import 'package:hits_app/data/network/napster_api.dart';
import 'package:hits_app/data/network/track_network_data_source.dart';
import 'package:hits_app/di/di_utils.dart';
import 'package:hits_app/domain/model/track.dart';
import 'track_disk_data_source.dart';

class FirestoreTrackDao extends TrackDao {
  FirestoreService _firestoreService = new FirestoreService();
  @override
  Future<void> deleteAllTracks() {
    return _firestoreService.deleteLikedTracks();
  }

  @override
  Future<List<FirestoreTrack>> getLikedTracks() {
    if (!_firestoreService.userExists()) {
      _firestoreService.addUser();
    }
    return _firestoreService.getLikedTracks().first;
  }

  @override
  Future<List<FirestoreTrack>> getTopTracks() async {
    Future<List<Track>?> futureTracks = injector<TrackNetworkDataSource>().getTopTracks();
    List<Track> tracks = [];
    futureTracks.then((value) => tracks = value!);
    List<FirestoreTrack> firestoreTracks = tracks.map((track) => track.toDatabaseModel()).toList();
    return new Future.value(firestoreTracks);
  }

  @override
  Future<FirestoreTrack?> getTrack(String id) async {
    Future<Track?> futureTrack = injector<TrackNetworkDataSource>().getTrack(id);
    Track? track;
    futureTrack.then((value) => track = value);
    FirestoreTrack firestoreTrack = track!.toDatabaseModel();
    return new Future.value(firestoreTrack);
  }

  @override
  Future<void> insertTracks(List<FirestoreTrack> tracks) async {
    tracks.forEach((track) {
      _firestoreService.setTrack(track);
    });
  }

}

// todo: swap to FirestoreTrack
extension on FirestoreTrack {
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
    );
  }
}