import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class DashboardComponent extends StatelessWidget {
  const DashboardComponent({Key? key, required this.user}) : super(key: key);
  final DocumentSnapshot user;
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
                  InkWell(
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 50,
                    ),
                    onTap: (){
                      FirebaseAuth.instance.signOut().then((value) =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginComponent(),
                            ),
                          )
                      );

                    },
                  ),
                  const Text(
                    "Dashboard",
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
                  )
                ],
              ),
            ),
          ]
      ),
    );
  }
}
