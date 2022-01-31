import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyberwatch/src/dashboard.dart';
import 'package:cyberwatch/src/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'register.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      users
          .doc(currentUser.uid)
          .get()
          .then((value) =>
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardComponent(user: value))
          )
      );
    }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginComponent())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('images/cyberwatch.png'),
        ),
      ),
    );
  }
}
