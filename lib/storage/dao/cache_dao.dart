import 'package:floor/floor.dart';
import 'package:flufly/storage/entity/cache_entity.dart';

@dao
abstract class CacheDao{
	@Query('SELECT * FROM cache')
	Future<List<CacheEntity>> all();

	@Query('SELECT * FROM cache WHERE key = :key')
	Future<CacheEntity?> findByKey(String key);

	@insert
	Future<void> create(CacheEntity cache);

	@Query('DELETE FROM cache WHERE key = :key')
	Future<void> delete(String key);

	@Query('DELETE FROM cache')
	Future<void> clean();

	@Query('SELECT * FROM cache WHERE key LIKE :key')
	Future<List<CacheEntity>> like(String key);

	@Query('DELETE FROM cache WHERE key LIKE :value')
	Future<void> deleteWithLike(String value);
}