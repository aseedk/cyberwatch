import 'package:cyberwatch/Backend/twitter.dart';
import 'package:cyberwatch/Backend/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'connect_social_media_accounts.dart';
import 'signup.dart';
import '../Backend/flutter_fire.dart';
import '../Backend/input_file.dart';
import '../Backend/mongo_implementation.dart';
final emailTextFieldController = TextEditingController();
final passwordTextFieldController = TextEditingController();
class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  get child => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ClipRRect(
                        child: Image.asset(
                          'images/cyberwatch1.png',
                          height: 200,
                          width: 300,
                        ),
                      ),
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        InputFile(
                          label: "Email",
                          labelText: '',
                          controller: emailTextFieldController
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputFile(
                            label: "Password",
                            obscureText: true,
                            labelText: '',
                            controller: passwordTextFieldController
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: const EdgeInsets.only(top: 30, left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        children: <Widget>[
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                              var uid = await loginUser(emailTextFieldController.text, passwordTextFieldController.text);
                              switch(uid) {
                                case 'No user found for that email.':
                                  {
                                    print('No user found for that email.');
                                  }
                                  break;

                                case 'Wrong password provided for that user.':
                                  {
                                    print(
                                        'Wrong password provided for that user.');
                                  }
                                  break;

                                default:
                                  {
                                    CyberWatchUser user = await loginUserAccount(uid!);
                                    print(user.toString());
                                    connectTwitterAPI(user.twitterAccessToken,user.twitterAccessSecret);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (
                                            context) => ConnectSocialMediaView(user: user),
                                      ),
                                    );
                                    break;
                                  }
                              }
                            },
                            color: const Color(0xff0095FF),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
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
                              CyberWatchUser user = await signInWithGoogle();
                              await registerUserAccountGoogle(user);
                              user = await loginUserAccount(user.id);
                              connectTwitterAPI(user.twitterAccessToken,user.twitterAccessSecret);
                              print(user.toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (
                                      context) => ConnectSocialMediaView(user: user),
                                ),
                              );
                            },
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            //add google icon inside the button
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'images/google.png',
                                  height: 25,
                                  width: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Login with Google",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpView(),
                            ),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Signup",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  onTap(Null Function() param0, Text text) {}
}

