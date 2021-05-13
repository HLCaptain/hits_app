// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorFloorTrackDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorTrackDatabaseBuilder databaseBuilder(String name) =>
      _$FloorTrackDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorTrackDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FloorTrackDatabaseBuilder(null);
}

class _$FloorTrackDatabaseBuilder {
  _$FloorTrackDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FloorTrackDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FloorTrackDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FloorTrackDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FloorTrackDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FloorTrackDatabase extends FloorTrackDatabase {
  _$FloorTrackDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FloorTrackDao? _trackDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tracks` (`type` TEXT, `id` TEXT, `disc` INTEGER, `href` TEXT NOT NULL, `playbackSeconds` INTEGER, `isExplicit` INTEGER, `name` TEXT, `isrc` TEXT NOT NULL, `shortcut` TEXT, `artistName` TEXT, `albumName` TEXT, `albumId` TEXT, `previewURL` TEXT, `isStreamable` INTEGER, `imagePath` TEXT, PRIMARY KEY (`isrc`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FloorTrackDao get trackDao {
    return _trackDaoInstance ??= _$FloorTrackDao(database, changeListener);
  }
}

class _$FloorTrackDao extends FloorTrackDao {
  _$FloorTrackDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _floorTrackInsertionAdapter = InsertionAdapter(
            database,
            'tracks',
            (FloorTrack item) => <String, Object?>{
                  'type': item.type,
                  'id': item.id,
                  'disc': item.disc,
                  'href': item.href,
                  'playbackSeconds': item.playbackSeconds,
                  'isExplicit': item.isExplicit == null
                      ? null
                      : (item.isExplicit! ? 1 : 0),
                  'name': item.name,
                  'isrc': item.isrc,
                  'shortcut': item.shortcut,
                  'artistName': item.artistName,
                  'albumName': item.albumName,
                  'albumId': item.albumId,
                  'previewURL': item.previewURL,
                  'isStreamable': item.isStreamable == null
                      ? null
                      : (item.isStreamable! ? 1 : 0),
                  'imagePath': item.imagePath
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FloorTrack> _floorTrackInsertionAdapter;

  @override
  Future<List<FloorTrack>> getAllTracks() async {
    return _queryAdapter.queryList('SELECT * FROM tracks',
        mapper: (Map<String, Object?> row) => FloorTrack(
            type: row['type'] as String?,
            id: row['id'] as String?,
            disc: row['disc'] as int?,
            href: row['href'] as String,
            playbackSeconds: row['playbackSeconds'] as int?,
            isExplicit: row['isExplicit'] == null
                ? null
                : (row['isExplicit'] as int) != 0,
            name: row['name'] as String?,
            isrc: row['isrc'] as String,
            shortcut: row['shortcut'] as String?,
            artistName: row['artistName'] as String?,
            albumName: row['albumName'] as String?,
            albumId: row['albumId'] as String?,
            previewURL: row['previewURL'] as String?,
            isStreamable: row['isStreamable'] == null
                ? null
                : (row['isStreamable'] as int) != 0,
            imagePath: row['imagePath'] as String?));
  }

  @override
  Future<FloorTrack?> getTrack(String id) async {
    return _queryAdapter.query('SELECT * FROM tracks WHERE id = ?1',
        mapper: (Map<String, Object?> row) => FloorTrack(
            type: row['type'] as String?,
            id: row['id'] as String?,
            disc: row['disc'] as int?,
            href: row['href'] as String,
            playbackSeconds: row['playbackSeconds'] as int?,
            isExplicit: row['isExplicit'] == null
                ? null
                : (row['isExplicit'] as int) != 0,
            name: row['name'] as String?,
            isrc: row['isrc'] as String,
            shortcut: row['shortcut'] as String?,
            artistName: row['artistName'] as String?,
            albumName: row['albumName'] as String?,
            albumId: row['albumId'] as String?,
            previewURL: row['previewURL'] as String?,
            isStreamable: row['isStreamable'] == null
                ? null
                : (row['isStreamable'] as int) != 0,
            imagePath: row['imagePath'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllTracks() async {
    await _queryAdapter.queryNoReturn('DELETE FROM tracks');
  }

  @override
  Future<void> insertTracks(List<FloorTrack> tracks) async {
    await _floorTrackInsertionAdapter.insertList(
        tracks, OnConflictStrategy.replace);
  }
}
