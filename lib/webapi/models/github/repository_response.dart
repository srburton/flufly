import 'package:json_annotation/json_annotation.dart';


part 'repository_response.g.dart';

@JsonSerializable()
class RepositoryResponse{

  int? id;
  String? name;

  RepositoryResponse({
    this.id,
    this.name
  });

  factory RepositoryResponse.fromJson(Map<String, dynamic> json)
    => _$RepositoryResponseFromJson(json);

  Map<String, dynamic> toJson()
    => _$RepositoryResponseToJson(this);

}