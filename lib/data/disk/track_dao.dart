import 'package:hits_app/data/disk/model/firestore_track.dart';

abstract class TrackDao {

  Future<List<FirestoreTrack>> getTopTracks();

  Future<List<FirestoreTrack>> getLikedTracks();

  Future<FirestoreTrack?> getTrack(String id);

  Future<void> insertTracks(List<FirestoreTrack> tracks);

  Future<void> deleteAllTracks();

  Future<void> deleteTrack(String id);
}
