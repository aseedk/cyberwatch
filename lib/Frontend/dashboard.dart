import 'package:cyberwatch/Backend/facebook.dart';
import 'package:cyberwatch/Backend/twitter.dart';
import 'package:cyberwatch/Backend/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DashboardView extends StatelessWidget {
  const DashboardView({Key? key, required this.user}) : super(key: key);
  final CyberWatchUser user;
  @override
  Widget build(BuildContext context) {
    final facebookTextFieldController = TextEditingController();
    final twitterTextFieldController = TextEditingController();
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              const Text(
                'Welcome to Your Dashboard',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Twitter Data',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: null,
                controller: twitterTextFieldController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Twitter Data',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () async{
                  String tweets = await getUserMentions(user);
                  twitterTextFieldController.text = tweets;
                },
                color: const Color(0xff0095FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                child: const Text(
                  "Fetch Twitter Data",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Facebook Data',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[900],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: facebookTextFieldController,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Facebook Data',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () async{
                  String posts = await getUserPostsFacebook(user.facebookAccessToken);
                  facebookTextFieldController.text = posts;
                }, //backend code to fetch data
                color: const Color(0xff0095FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                child: const Text(
                  "Fetch Facebook Data",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    )));
  }
}
