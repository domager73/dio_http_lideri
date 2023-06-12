// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubProfile _$GithubProfileFromJson(Map<String, dynamic> json) =>
    GithubProfile(
      createdAt: '${json['created_at']}',
      avatarUrl: json['avatar_url'],
      publicRepos: "${json['public_repos']}",
      login: json['login'] as String,
    );
