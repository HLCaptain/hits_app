import 'package:floor/floor.dart';
import 'package:hits_app/data/disk/model/floor_track.dart';
import 'package:hits_app/data/disk/track_dao.dart';
import 'model/floor_track.dart';

@dao
abstract class FloorTrackDao implements TrackDao {

  @Query("SELECT * FROM tracks")
  Future<List<FloorTrack>> getAllTracks();

  @Query('SELECT * FROM tracks WHERE id = :id')
  Future<FloorTrack?> getTrack(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTracks(List<FloorTrack> tracks);

  @Query("DELETE FROM tracks")
  Future<void> deleteAllTracks();
}
