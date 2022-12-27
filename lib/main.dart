import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flufly/pages/home.dart';
import 'package:flufly/palette.dart';
import 'package:flufly/settings.dart';
import 'package:flufly/translate.dart';
import 'package:flufly/storage/db.dart';
import 'package:flufly/storage/db_sec.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Settings
  await Settings.load('assets/settings.json');

  //i18n
  var translate = TranslateLanguageNotifier(["pt_BR", "en_US"])..load();

  //Load map palette colors
  await Palette.load('assets/palette.json');

  //Load database
  await Db.load(Settings.get("db")!);

  //Load database security
  DbSec.load();

  runApp(MultiProvider(
    child: flufly(),
    providers: [
      //i18n
      ChangeNotifierProvider<TranslateLanguageNotifier>(create: (context) => translate),
    ]
  ));
}

class flufly extends StatelessWidget {
  const flufly({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<TranslateLanguageNotifier>(builder: (context, model, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
          debugShowCheckedModeBanner: false,
          locale: model.appLocale,
          supportedLocales: model.supportedLocales,
          localizationsDelegates: [
            Translate.delegate
          ]
      );
    });
  }
}