import 'package:firebase_auth/firebase_auth.dart';

void registerUser() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "barry.allen@example.com",
        password: "SuperSecretPassword!"
    );
    print("USER REGISTERED BC");
    print(userCredential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
void loginUser() async{
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "barry.allen@example.com",
        password: "SuperSecretPassword!"
    );
    print("USER Logged BC");
    print(userCredential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
void logoutUser() async{
  await FirebaseAuth.instance.signOut();
}