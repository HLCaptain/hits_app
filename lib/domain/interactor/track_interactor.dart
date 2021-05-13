import 'package:flutter/foundation.dart';
import 'package:hits_app/data/disk/track_disk_data_source.dart';
import 'package:hits_app/data/network/track_network_data_source.dart';
import 'package:hits_app/domain/model/track.dart';

class TrackInteractor {
  final TrackDiskDataSource _trackDiskDataSource;
  final TrackNetworkDataSource _trackNetworkDataSource;

  TrackInteractor(
      this._trackDiskDataSource,
      this._trackNetworkDataSource,
      );

  Future<List<Track>> getAllTracks() async {
    return await _trackDiskDataSource.getAllTracks() ?? [];
  }

  Future<void> refreshTracks() async {
    debugPrint("Downloading tracks from the network");
    final tracks = await _trackNetworkDataSource.getTopTracks();

    debugPrint("Saving downloaded tracks to disk");
    await _trackDiskDataSource.saveTracks(tracks ?? []);
  }

  Future<Track?> getTrackById(String id) async{
    print("Getting track $id from disk");
    return await _trackDiskDataSource.getTrack(id);
  }
}
