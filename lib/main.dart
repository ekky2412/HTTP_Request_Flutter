import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_request/user_profile_model.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserProfile userProfile = null as UserProfile;
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Github Profil"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            (userProfile != null)
                ? _profile(userProfile)
                : Container(
              padding: EdgeInsets.all(30),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Input Username",
                ),
                controller: myController,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  UserProfile.connectToAPI(myController.text).then((value) {
                    userProfile = value;
                    setState(() {});
                  });
                },
                child: Text("Submit")),
          ],
        )),
      ),
    );
  }
}

Widget _profile(UserProfile userProfile) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Image.network(userProfile.avatar_url.toString(), width: 100),
      Text(userProfile.login.toString()),
      Text(userProfile.name.toString()),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Following : " + userProfile.following.toString()),
          Text("Followers : " + userProfile.followers.toString()),
          Text("Repositories : " + userProfile.public_repos.toString())
        ],
      ),
    ],
  );
}
