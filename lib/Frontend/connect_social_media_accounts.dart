import 'package:cyberwatch/Backend/facebook.dart';
import 'package:cyberwatch/Backend/mongo_implementation.dart';
import 'package:cyberwatch/Backend/twitter.dart';
import 'package:cyberwatch/Backend/user.dart';
import 'package:cyberwatch/Frontend/dashboard.dart';
import 'package:flutter/material.dart';

class ConnectSocialMediaView extends StatelessWidget {
  const ConnectSocialMediaView({Key? key, required this.user}) : super(key: key);
  final CyberWatchUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    var accessToken = await loginFacebook();
                    user.facebookAccessToken = accessToken;
                    print(user.toString());
                    await linkFacebookAccount(user);
                    /*await getUserPostsFacebook(user.facebookAccessToken);
                    await getUserVideosFacebook(user.facebookAccessToken);
                    await getUserPhotosFacebook(user.facebookAccessToken);*/

                  },
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Connect with Facebook",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    List<String?> twitterUser = await loginTwitter();
                    user.twitterAccessToken = twitterUser[0];
                    user.twitterAccessSecret = twitterUser[1];
                    await linkTwitterAccessTokenWithAccount(user);
                    await linkTwitterAccessSecretWithAccount(user);
                    /*await getUserMentions();
                    await getUserTweets();*/
                  },
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Connect with Twitter",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardView(user: user),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Move To Dashboard",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ]),
        ));
  }
}
