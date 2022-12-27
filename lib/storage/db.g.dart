// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DbBuilder databaseBuilder(String name) => _$DbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DbBuilder inMemoryDatabaseBuilder() => _$DbBuilder(null);
}

class _$DbBuilder {
  _$DbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$DbBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DbBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<Db> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$Db();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$Db extends Db {
  _$Db([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CacheDao? _cacheInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `cache` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `key` TEXT NOT NULL, `value` TEXT NOT NULL, `expiry` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CacheDao get cache {
    return _cacheInstance ??= _$CacheDao(database, changeListener);
  }
}

class _$CacheDao extends CacheDao {
  _$CacheDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _cacheEntityInsertionAdapter = InsertionAdapter(
            database,
            'cache',
            (CacheEntity item) => <String, Object?>{
                  'id': item.id,
                  'key': item.key,
                  'value': item.value,
                  'expiry': item.expiry
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CacheEntity> _cacheEntityInsertionAdapter;

  @override
  Future<List<CacheEntity>> all() async {
    return _queryAdapter.queryList('SELECT * FROM cache',
        mapper: (Map<String, Object?> row) => CacheEntity(
            row['id'] as int?,
            row['key'] as String,
            row['value'] as String,
            row['expiry'] as String));
  }

  @override
  Future<CacheEntity?> findByKey(String key) async {
    return _queryAdapter.query('SELECT * FROM cache WHERE key = ?1',
        mapper: (Map<String, Object?> row) => CacheEntity(
            row['id'] as int?,
            row['key'] as String,
            row['value'] as String,
            row['expiry'] as String),
        arguments: [key]);
  }

  @override
  Future<void> delete(String key) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM cache WHERE key = ?1', arguments: [key]);
  }

  @override
  Future<void> clean() async {
    await _queryAdapter.queryNoReturn('DELETE FROM cache');
  }

  @override
  Future<List<CacheEntity>> like(String key) async {
    return _queryAdapter.queryList('SELECT * FROM cache WHERE key LIKE ?1',
        mapper: (Map<String, Object?> row) => CacheEntity(
            row['id'] as int?,
            row['key'] as String,
            row['value'] as String,
            row['expiry'] as String),
        arguments: [key]);
  }

  @override
  Future<void> deleteWithLike(String value) async {
    await _queryAdapter.queryNoReturn('DELETE FROM cache WHERE key LIKE ?1',
        arguments: [value]);
  }

  @override
  Future<void> create(CacheEntity cache) async {
    await _cacheEntityInsertionAdapter.insert(cache, OnConflictStrategy.abort);
  }
}
