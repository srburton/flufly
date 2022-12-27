import 'package:flufly/storage/db_sec.dart';

class AuthDbSecDao {

  final DbSec? context;

  AuthDbSecDao(this.context);

  static const DB_SEC_KEY = 'authorization';

  Future<String> get bearer async
    => "Bearer ${await token}";

  Future<String?> get token async{
    var data = await context?.read(key: DB_SEC_KEY);
    if(data != null && data.isNotEmpty){
      return data;
    }
  }

  Future<void> save(String token) async
    => context?.write(key: DB_SEC_KEY, value: token);

  Future<void> delete() async
    => await context?.delete(key: DB_SEC_KEY);

}