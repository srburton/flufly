import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flufly/storage/dao/auth_dbsec_dao.dart';

class DbSec extends FlutterSecureStorage{

	static DbSec? context;

	AuthDbSecDao get auth => AuthDbSecDao(context);

	static Future<DbSec> load() async{
		return context = DbSec();
	}
}