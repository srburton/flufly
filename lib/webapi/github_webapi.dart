import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
import 'package:flufly/webapi/models/github/repository_response.dart';
import 'package:flufly/webapi/services/github_service.dart';

part 'github_webapi.g.dart';

@RestApi()
abstract class GithubWebApi {

  factory GithubWebApi(Dio dio) = _GithubWebApi;

  static GithubWebApi create() => GithubWebApi(GitHubService.service());

  @GET('/users/{username}/repos')
  Future<List<RepositoryResponse>> repos(@Path() username);

}