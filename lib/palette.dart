import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flufly/cross/extensions/color_extension.dart';

class Palette{

  static Color primary = Palette.get('primary');
  static Color secondary = Palette.get('secondary');
  static Color success = Palette.get('success');
  static Color danger = Palette.get('danger');
  static Color warning = Palette.get('warning');
  static Color info = Palette.get('info');
  static Color light = Palette.get('light');
  static Color dark = Palette.get('dark');
  static Color muted = Palette.get('muted');
  static Color link = Palette.get('link');

  static Map<String, dynamic>? palette;

  static Color get(String key)
    =>  ColorExtension.fromHex(Palette.palette?[key]);

  static Future<void> load(@required String src) async
  {
    assert(src != null || src.length == 0);

    String jsonString = await rootBundle.loadString(src);

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    palette = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }
}