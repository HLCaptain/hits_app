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

  Future<List<Track>> getTopTracks() async {
    return await _trackNetworkDataSource.getTopTracks() ?? [];
  }

  Future<void> refreshTopTracks() async {
    debugPrint("Downloading tracks from the network");
    final tracks = await _trackNetworkDataSource.getTopTracks();
  }

  Future<Track?> getTrackById(String id) async {
    print("Getting track $id from disk");
    return await _trackNetworkDataSource.getTrack(id);
  }
}
