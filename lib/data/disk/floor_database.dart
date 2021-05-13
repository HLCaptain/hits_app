import 'dart:async';

import 'package:floor/floor.dart';
import 'package:hits_app/data/disk/floor_track_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'model/floor_track.dart';

part 'floor_database.g.dart';

@Database(
  version: 1,
  entities: [FloorTrack],
)

abstract class FloorTrackDatabase extends FloorDatabase {
  FloorTrackDao get trackDao;
}
