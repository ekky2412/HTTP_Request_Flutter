import 'package:flutter/material.dart';
import 'package:http_request/user_profile_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserProfile userProfile = UserProfile();
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
            (userProfile.name.isNotEmpty)
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
                  print("myController.text ${myController.text}");
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

  Widget _profile(UserProfile userProfile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildGithubAvatar(),
        Text(userProfile.login.toString()),
        Text(userProfile.name.toString()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Following : " + userProfile.following.toString()),
            Text("Followers : " + userProfile.followers.toString()),
            Text("Repositories : " + userProfile.publicRepos.toString())
          ],
        ),
      ],
    );
  }

  Widget _buildGithubAvatar() {
    if (userProfile.avatarUrl.isNotEmpty) {
      return Image.network(userProfile.avatarUrl.toString(), width: 100);
    } else {
      return SizedBox.shrink();
    }
  }
}
