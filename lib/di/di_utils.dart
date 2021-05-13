import 'package:get_it/get_it.dart';
import 'package:hits_app/data/disk/floor_database.dart';
import 'package:hits_app/data/disk/track_dao.dart';
import 'package:hits_app/data/disk/track_disk_data_source.dart';
import 'package:hits_app/data/network/dio_napster_service.dart';
import 'package:hits_app/data/network/napster_api.dart';
import 'package:hits_app/data/network/track_network_data_source.dart';
import 'package:hits_app/domain/interactor/track_interactor.dart';
import 'package:hits_app/ui/tracks/track_list_bloc.dart';
import 'package:hits_app/ui/music_player/music_player_bloc.dart';

final injector = GetIt.instance;

void initDependencies() {
  injector.registerSingleton<NapsterApi>(NapsterService());

  injector.registerSingleton(
    TrackNetworkDataSource(injector<NapsterApi>()),
  );

  injector.registerSingletonAsync<TrackDao>(() async {
    final database = await $FloorFloorTrackDatabase
        .databaseBuilder("napster_database.db")
        .build();
    return database.trackDao;
  });

  injector.registerSingletonAsync(
    () async {
      return TrackDiskDataSource(
        injector<TrackDao>(),
      );
    },
    dependsOn: [TrackDao],
  );

  injector.registerSingletonAsync(
    () async {
      return TrackInteractor(
        injector<TrackDiskDataSource>(),
        injector<TrackNetworkDataSource>(),
      );
    },
    dependsOn: [TrackDiskDataSource],
  );

  injector.registerFactory(
    () => TrackListBloc(
      injector<TrackInteractor>(),
    ),
  );

  injector.registerFactory(
    () => MusicPlayerBloc(
      injector<TrackInteractor>(),
    ),
  );
}
