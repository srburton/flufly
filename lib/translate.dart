import 'dart:convert';
import 'dart:core';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:flufly/cross/helpers/platform_helper.dart';

class Translate {
  final Locale? locale;
  Map<String, dynamic>? _localizedStrings;

  final Logger _logger = Logger(
      level: Level.info
  );

  Translate(this.locale);

  // Helper method to keep the code in the widget concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static Translate? of(BuildContext context) {
    return Localizations.of<Translate>(context, Translate);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<Translate> delegate = _TranslateDelegate();

  dynamic _getSafeLocalizedStrings(String key){
    try{
      return _localizedStrings?[key];
    }catch(e){
      _logger.w(e);
      return key;
    }
  }

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString = await rootBundle.loadString('assets/i18n/${locale?.languageCode}_${locale?.countryCode?.toUpperCase()}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value);
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String byKey(String key) {
    var str = _getSafeLocalizedStrings(key);
    if (str == null || str == "")
      return key;
    return str;
  }

  List<T> byKeyList<T>(String key) {
    var dlist = _localizedStrings?[key] as List<T>;

    if(T == int)
      return dlist.map((e) => int.parse(e.toString())).toList() as List<T>;

    if(T == String)
      return dlist.map((e) => e.toString()).toList() as List<T>;

    if(T == double)
      return dlist.map((e) => double.parse(e.toString())).toList() as List<T>;

    return dlist;
  }

  Map<String, dynamic> byKeyMap(String key)
  => _localizedStrings?[key];

  T? byKeyMapKeyValue<T>(String key, String keyValue) {
    try{
      return byKeyMap(key)[keyValue] as T;
    }catch(e){
      _logger.w(e);
    }
  }

  String  byKeyMapAndReplace(String key, String index, String from, String replace) {
    var map = byKeyMap(key);
    if(map.keys.any((e) => e == index)) {
      var text = map[index];
      return text.replaceAll(RegExp("{{$from}}"), replace);
    }
    return key;
  }

  String byKeyAndReplace(String key, Pattern from, String replace){
    var str = _localizedStrings?[key];
    return str.replaceAll(from, replace);
  }

  String byKeyAndReplaceByIndexArray(String key, List<String> from){
    var str = _localizedStrings?[key];

    for(var i = 0; i < from.length; i++)
      str = str.replaceAll(RegExp("[\[\]$i]"), from[i]);

    return str;
  }

  String byKeyAndReplaceByKey(String key, Map<String, String> from) {
    var str = _localizedStrings?[key] ?? key;
    try {
      from.forEach((mkey, value) =>
      str = str.replaceAll(RegExp("{{$mkey}}"), from[mkey]));
    }catch(e){

    }
    return str;
  }
}

class _TranslateDelegate extends LocalizationsDelegate<Translate> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _TranslateDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['pt', 'en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<Translate> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    Translate localizations = new Translate(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_TranslateDelegate old) => false;
}

class TranslateLanguageNotifier extends ChangeNotifier {

  //['pt_BR', 'en_US', 'es_CH', ...]
  List<String> languages;

  Locale? _appLocale;

  static const DEFAULT_LOCALE = Locale('en','US');

  TranslateLanguageNotifier(this.languages);

  final _logger = Logger(
    printer: PrettyPrinter(
        colors: false
    ),
  );

  Locale get appLocale
    => _appLocale ?? DEFAULT_LOCALE;

  String get languageCode
    => "${_appLocale?.languageCode}_${_appLocale?.countryCode?.toUpperCase()}";

  List<Locale> get supportedLocales{
    final locales = <Locale>[];
    for(final language in languages){
      //Input: pt_BR Output: pt
      final languageCode = language.substring(0, 2);
      //Input: pt_BR Output: BR
      final countryCode = language.substring(3, 5)
          .toUpperCase();
      locales.add(Locale(languageCode, countryCode));
    }
    return locales;
  }

  Future<void> load() async {
    try {
      _appLocale = PlatformHelper.locale;

      _logger.i([
        "Platform: ${PlatformHelper.locale}",
        "Default: ${DEFAULT_LOCALE.languageCode}_${DEFAULT_LOCALE.countryCode}"
      ], 'Pipeline language load');
    } catch (e) {
      _appLocale = DEFAULT_LOCALE;
    }
  }

  /*
  * Example:
  * var appLanguage = Provider.of<TranslateLanguage>(context, listen: false);
	* appLanguage.changeLanguage(Locale('pt', 'BR'));
  * */
  Future<void> changeLanguage(Locale locale) async {
    //Check toggle is equals
    if (_appLocale == locale)
      return;

    //['pt_BR', 'en_US', ...]
    for(final language in languages){
      //Input: pt_BR Output: pt
      final languageCode = language.substring(0, 2);
      //Input: pt_BR Output: BR
      final countryCode = language.substring(3, 5)
          .toUpperCase();

      if(locale.languageCode == languageCode && locale.countryCode ==  countryCode){
        _appLocale = Locale(languageCode, countryCode);
      }
    }
    //Notify changes for app.
    notifyListeners();
  }

  Future<void> notifyChange() async {
    //Notify changes for app.
    notifyListeners();
  }
}