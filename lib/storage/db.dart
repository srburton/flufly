import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:flufly/storage/dao/cache_dao.dart';
import 'package:flufly/storage/entity/cache_entity.dart';

part 'db.g.dart'; // the generated code will be there

@Database(version: 1, entities: [CacheEntity])
abstract class Db extends FloorDatabase {

	CacheDao get cache;

	/*
	## Migration production only

	https://pub.dev/packages/floor#migrations

	static const int startVersion = 1;
	static const int endVersione  = 2;

	final migration1to2 = Migration(startVersion, endVersione, (database) async {
		//await database.execute('ALTER TABLE person ADD COLUMN nickname TEXT');
	});
*/
	static Db? context;

	Future<void> drop() async {
		await database.execute('DELETE FROM cache');
	}

	static Future<Db> load(String database) async {
		return context = await $FloorDb.databaseBuilder(database)
				 															 //.addMigrations(migrations)
																			 .build();
	}
}