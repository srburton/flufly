import 'package:floor/floor.dart';

@Entity(tableName: 'cache')
class CacheEntity{

	@PrimaryKey(autoGenerate: true)
	final int? id;

	final String key;

	final String value;

	final String expiry;

	CacheEntity(this.id, this.key, this.value, this.expiry);

	CacheEntity.only({
		this.id,
		required this.key,
		required this.value,
		required this.expiry
	});
}