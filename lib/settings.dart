import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Settings {

  static Map<String, String>? settings;

  static String webapi = settings?['webapi'] ?? '';
  static String cdn = settings?['cdn']?? '';

  static String? get(String key)
    => settings?[key];

  static String getAndReplace(String key, Map<String, String> from) {
    var str = settings?[key] ?? key;
    try {
      from.forEach((mkey, value) =>
        str = str.replaceAll(RegExp("{{$mkey}}"), from[mkey]!));
    }catch(e){

    }
    return str;
  }

  static Future<void> load(@required String src) async {
    assert(src != null || src.length == 0);

    String jsonString = await rootBundle.loadString(src);

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    settings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }
}