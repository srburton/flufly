import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flufly/palette.dart';
import 'package:flufly/settings.dart';
import 'package:flufly/translate.dart';
import 'package:flufly/webapi/github_webapi.dart';
import 'package:flufly/webapi/models/github/repository_response.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var i18n = Provider.of<TranslateLanguageNotifier>(context, listen: false);

    var githubApi = GithubWebApi.create();

    return Scaffold(
      backgroundColor: Palette.primary,
      body: Center(
        child: FutureBuilder<List<RepositoryResponse>>(
          future: githubApi.repos('srburton'),
          builder: (context, snapshot){
           if(snapshot.hasData){
             return ListView.builder(
               itemCount: snapshot.data?.length ?? 0,
               itemBuilder: (context, item) {
                 var repo = snapshot.data?[item];
                 return ListTile(
                   dense: true,
                   title: Text(repo?.name??''),
                   tileColor: Colors.white
                 );
               },
             );
           }else{
             return Text('Await...',
               style: TextStyle(
                   fontSize: 30,
                   color: Colors.white
               ),
             );
           }
          },
        ),
      ),
    );
  }
}