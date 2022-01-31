import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyberwatch/src/connect_social_media_accounts.dart';
import 'package:cyberwatch/src/dashboard.dart';
import 'package:cyberwatch/src/register.dart';
import 'package:cyberwatch/src/update_profile_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({Key? key}) : super(key: key);

  @override
  _LoginComponentState createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  bool _obscureText = true;
  bool _emailError = false;
  bool _passwordError = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool emailCheck(var testValue){
    String regex = r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(regex);
    return regExp.hasMatch(testValue);
  }
  bool passwordCheck(var testValue) {
    String regex = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    RegExp regExp = RegExp(regex,
        caseSensitive: false);
    return regExp.hasMatch(testValue);
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    "Login",
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        'images/cyberwatch1.png',
                        height: 200,
                        width: 300,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: TextField(
                        controller: emailController,
                        onChanged: (text) async {
                          await Future.delayed(const Duration(milliseconds: 1000), () {});
                          if(text == ""){
                            setState(() {
                              _emailError = false;
                            });
                          }
                          else if (!emailCheck(text)) {
                            setState(() {
                              _emailError = true;
                            });
                          }else{
                            setState(() {
                              _emailError = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Email Address',
                            hintText: "Enter Your Email",
                            errorText: _emailError ? "Email format is Incorrect": null,
                            icon: const Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Icon(Icons.contact_mail))
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: TextField(
                          controller: passwordController,
                          onChanged: (text){
                            if (text == ""){
                              setState(() {
                                _passwordError = false;
                              });
                            }else if(!passwordCheck(text)){
                              setState(() {
                                _passwordError = true;
                              });
                            }else{
                              setState(() {
                                _passwordError = false;
                              });
                            }
                          },
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              hintText: "Enter Your Password",
                              errorText: _passwordError?"Password must contains 8 Character & 1 Digit": null,
                              icon: const Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Icon(Icons.lock)),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                      _obscureText ? Icons.visibility : Icons.visibility_off
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  }
                              )
                          )
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 50),
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterComponent(),
                              ),
                            );
                          },
                          child: const Text(
                              "Forgot Password?"
                              ,textAlign: TextAlign.left,
                          ),
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async{
                          CollectionReference users = FirebaseFirestore.instance.collection('users');
                          try {
                            UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                           users
                               .doc(userCredential.user!.uid)
                               .get()
                               .then((value) => {
                                 if (value.get('facebookAccessToken') == "" || value.get('twitterAccessToken') == "" || value.get("twitterAccessSecret") == ""){
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) => ConnectSocialMediaAccount(user: value),
                                     ),
                                   )
                                 } else if (value.get('verified') == false){
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) => DashboardComponent(user: value),
                                     ),
                                   )
                                 }
                               }
                               )
                            ;
                            Fluttertoast.showToast(
                                msg: "User logged in",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              Fluttertoast.showToast(
                                  msg: "Email address not registered",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            } else if (e.code == 'wrong-password') {
                              Fluttertoast.showToast(
                                  msg: "Incorrect Password",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          }
                          catch (e) {
                            Fluttertoast.showToast(
                                msg: e.toString(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async{
                          CollectionReference users = FirebaseFirestore.instance.collection('users');
                          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                          final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
                          final credential = GoogleAuthProvider.credential(
                            accessToken: googleAuth?.accessToken,
                            idToken: googleAuth?.idToken,
                          );
                          UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                          users
                              .doc(userCredential.user!.uid)
                              .get().then((DocumentSnapshot value) => {
                                if (!value.exists){
                                  users.doc(userCredential.user!.uid).set({
                                    'name': userCredential.user!.displayName,
                                    'email': userCredential.user!.email,
                                    'gender': '',
                                    'country': '',
                                    'dateOfBirth': '',
                                    'facebookAccessToken': '',
                                    'twitterAccessToken': '',
                                    'twitterAccessSecret': '',
                                    'verified': false
                                  }).then((snapshotValue) => {
                                  Fluttertoast.showToast(
                                    msg: "Google Account Registered",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                    ),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) => UpdateProfileGoogle(user: value),
                                    ),
                                  )
                                  })
                                }else if(value.get('gender') == "" || value.get('country') == "" || value.get('dateOfBirth') == ""){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateProfileGoogle(user: value),
                                    ),
                                  )
                                }else if(value.get('facebookAccessToken') == "" || value.get('twitterAccessToken') == "" || value.get("twitterAccessSecret") == ""){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ConnectSocialMediaAccount(user: value),
                                    ),
                                  )
                                }else{
                                      Fluttertoast.showToast(
                                      msg: "User Logged In",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashboardComponent(user: value),
                                    ),
                                  )
                                }
                          });

                        },
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
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterComponent(),
                              ),
                            );
                          },
                          child: const Text("Don't have an account? Sign Up"),
                        )
                    )
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
