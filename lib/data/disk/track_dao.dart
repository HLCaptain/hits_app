import 'model/floor_track.dart';

abstract class TrackDao {

  Future<List<FloorTrack>> getAllTracks();

  Future<FloorTrack?> getTrack(String id);

  Future<void> insertTracks(List<FloorTrack> tracks);

  Future<void> deleteAllTracks();
}
