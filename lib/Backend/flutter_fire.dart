import 'package:cyberwatch/Backend/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<String?> registerUser(email, password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    print("USER REGISTERED BC");
    return(userCredential.user!.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return('The account already exists for that email.');
    }
  } catch (e) {
    return(e.toString());
  }
}
Future<String?> loginUser(email, password) async{
  try {
    print(email);
    print(password);
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),
    );
    return(userCredential.user!.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      return('Wrong password provided for that user.');
    }
  }
  catch (e) {
    return(e.toString());
  }
}
Future<CyberWatchUser> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  CyberWatchUser user = CyberWatchUser();
  user.id = userCredential.user!.uid;
  user.fullName = userCredential.user!.displayName;
  user.email = userCredential.user!.email;
  // Once signed in, return the UserCredential
  return user;
}

void getCurrentUser(){
  var currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    print(currentUser.uid);
  }
}

void logoutUser() async{
  await FirebaseAuth.instance.signOut();
}