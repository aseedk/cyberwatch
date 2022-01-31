import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyberwatch/src/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twitter_login/twitter_login.dart';

class ConnectSocialMediaAccount extends StatelessWidget {
  const ConnectSocialMediaAccount({Key? key, required this.user}) : super(key: key);
  final DocumentSnapshot user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(bottom: 10, top: 20),
            decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(15, 10),
                    blurRadius: 30,
                    color: Colors.grey,
                  )]
            ),
            height: MediaQuery.of(context).size.height * 0.125,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  "Connect Social Media",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
                Container(
                  padding: const EdgeInsets.all(12.5),
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'images/logo.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image:
                    DecorationImage(image: AssetImage('images/welcome.png')),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      final LoginResult result = await FacebookAuth.instance.login();
                      if (result.status == LoginStatus.success) {
                        final AccessToken accessToken = result.accessToken!;
                        CollectionReference users = FirebaseFirestore
                            .instance.collection('users');
                        users
                            .doc(user.id)
                            .update({
                          'facebookAccessToken': accessToken.token
                        });
                        Fluttertoast.showToast(
                            msg: "Facebook account linked",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Fluttertoast.showToast(
                            msg: result.message.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: const Text('Connect with Facebook'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      final twitterLogin = TwitterLogin(
                        apiKey: "4aNp2JGbx8eDXMvJzhjyWU8lf",
                        apiSecretKey: "QgJbqWNRMjGamwDLbvaim9z3HcZe4OVRjFDnHdwMMAXDhHci0l",
                        redirectURI: 'cyberwatch://',
                      );
                      final authResult = await twitterLogin.login();
                      switch (authResult.status) {
                        case TwitterLoginStatus.loggedIn:
                          print('====== Login success ======');
                          print(authResult.authToken);
                          print(authResult.authTokenSecret);
                          CollectionReference users = FirebaseFirestore
                              .instance.collection('users');
                          users
                              .doc(user.id)
                              .update({
                            'twitterAccessToken': authResult.authToken,
                            'twitterAccessSecret': authResult.authTokenSecret
                          });
                          Fluttertoast.showToast(
                              msg: "Twitter account linked",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          break;
                        case TwitterLoginStatus.cancelledByUser:
                          print('====== Login cancel ======');
                          //break;
                          Fluttertoast.showToast(
                              msg: "Login cancelled by user",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          break;
                        case TwitterLoginStatus.error:
                          Fluttertoast.showToast(
                              msg: "Error occurred",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          break;
                        case null:
                          print('====== Login error ======');
                          Fluttertoast.showToast(
                              msg: "Error occurred",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          break;
                      }
                    },
                    child: const Text('Connect with Twitter'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardComponent(user: user),
                        ),
                      );
                    },
                    child: const Text('Go to dashboard'),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
