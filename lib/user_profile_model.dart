import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProfile {
  final String login;
  final String name;
  final int following;
  final int followers;
  final int publicRepos;
  final String avatarUrl;

  UserProfile({
    this.login = "",
    this.name = "",
    this.following = 0,
    this.followers = 0,
    this.publicRepos = 0,
    this.avatarUrl = "",
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        login: json['login'],
        name: json['name'],
        following: json['following'],
        followers: json['followers'],
        publicRepos: json['public_repos'],
        avatarUrl: json['avatar_url']);
  }

  static Future<UserProfile> connectToAPI(String user) async {
    Uri apiURL = Uri.parse("https://api.github.com/users/" + user);

    var apiResult = await http.get(apiURL);

    if (apiResult.statusCode == 200) {
      var jsonObject = json.decode(apiResult.body);
      return UserProfile.fromJson(jsonObject);
    }
    throw Exception('Failed to load Profile');
  }
}
