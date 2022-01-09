import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfile {
  final String login;
  final String name;
  final int following;
  final int followers;
  final int public_repos;
  final String avatar_url;

  UserProfile(
      {required this.login,
      required this.name,
      required this.following,
      required this.followers,
      required this.public_repos,
      required this.avatar_url});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        login: json['login'],
        name: json['name'],
        following: json['following'],
        followers: json['followers'],
        public_repos: json['public_repos'],
        avatar_url: json['avatar_url']
    );
  }

  static Future<UserProfile> connectToAPI(String user) async {
    String apiURL = "https://api.github.com/users/" + user;

    var apiResult = await http.get(apiURL);

    if(apiResult.statusCode == 200){
      var jsonObject = json.decode(apiResult.body);
      return UserProfile.fromJson(jsonObject);
    }
      throw Exception('Failed to load Profile');
  }
}
