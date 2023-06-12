import 'package:json_annotation/json_annotation.dart';

part "profile.g.dart";

@JsonSerializable(createToJson: true)
class GithubProfile {
  final String login;
  final String createdAt;
  final String publicRepos;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  const GithubProfile({
    required this.createdAt,
    required this.avatarUrl,
    required this.publicRepos,
    required this.login,
  });

  factory GithubProfile.fromJson(Map<String, dynamic> json) =>
      _$GithubProfileFromJson(json);
}
