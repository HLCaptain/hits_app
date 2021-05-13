import 'package:hits_app/data/network/dio_napster_service.dart';
import 'package:hits_app/domain/model/track.dart';

import 'model/network_track.dart';
import 'napster_api.dart';

class TrackNetworkDataSource {
  final NapsterApi _napsterApi;

  TrackNetworkDataSource(this._napsterApi);

  Future<List<Track>?> getTopTracks() async {
    final networkResponse = await _napsterApi.getTopTracks();

    if (networkResponse.response.statusCode != 200) return null;

    final networkTracks = networkResponse.data.tracks;

    return networkTracks.map((track) => track.toDomainModel()).toList();
  }
}

extension on NetworkTrack {
  Track toDomainModel() {
    return Track(
        type: this.type,
        id: this.id,
        disc: this.disc,
        href: this.href,
        playbackSeconds: this.playbackSeconds,
        isExplicit: this.isExplicit,
        name: this.name,
        isrc: this.isrc,
        shortcut: this.shortcut,
        artistName: this.artistName,
        albumName: this.albumName,
        albumId: this.albumId,
        previewURL: this.previewURL,
        isStreamable: this.isStreamable,
        imagePath: "$baseUrl/imageserver/v2/albums/$albumId/images/500x500.png"
    );
  }
}
