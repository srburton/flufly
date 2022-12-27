import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flufly/webapi/interceptors/cache_custom_interceptor.dart';

class GitHubService {

  static const TIMEOUT = 5000;

  static Dio service() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.github.com',
      connectTimeout: TIMEOUT,
      receiveTimeout: TIMEOUT
    ));
    dio.interceptors.add(CacheCustomInterceptor(dio));
    dio.interceptors.add(PrettyDioLogger(
        request: true,
        error: true,
        responseBody: true
    ));
    return dio;
  }
}