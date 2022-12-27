import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:flufly/storage/db.dart';
import 'package:flufly/storage/entity/cache_entity.dart';

class CacheCustomInterceptor extends Interceptor {

  final Dio dio;
  final db = Db.context;
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  CacheCustomInterceptor(this.dio);

  @override
  onRequest(options, handler) async {
    try {
      //Cache result
      if (options.headers.containsKey('cache') && options.headers['cache'] != null) {
        //Force ignore cache
        if (!options.headers.containsKey('cache-refresh') && !options.headers['cache-refresh']) {
          var key = options.uri.toString();
          var milliseconds = int.parse(options.headers['cache']);

          //Find value with key and check is not expiry.
          var result = await db?.cache.findByKey(key);
          if (result != null && DateTime.now().difference(DateTime.parse(result.expiry)).inMilliseconds <= milliseconds) {
            return handler.next(jsonDecode(result.value));
          } else {
            await db?.cache.delete(key);
          }
        }
      }
    } catch (error) {
      logger.e(error);
    }
    return handler.next(options);
  }

  @override
  onResponse(response, handler) async {
    try {
      if (response.headers.value('cache') != null) {
        var key = response.realUri.toString();
        var milliseconds = int.parse(response.headers.value('cache')!);

        //Delete key and crete new item
        if (response.statusCode != null && response.statusCode == 200 && response.data != null) {
          await db?.cache.delete(key);
          await db?.cache.create(CacheEntity.only(
              key: key,
              value: jsonEncode(response.data),
              expiry: DateTime.now().add(Duration(milliseconds: milliseconds)).toString()
          ));
        }
      }
    }catch(error){
      logger.e(error);
    }

    return handler.next(response);
  }

  @override
  onError(DioError e, handler) async{
    logger.e(e);
    handler.next(e);
  }
}