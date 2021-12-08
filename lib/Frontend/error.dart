import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //error page saying sorry for the inconvenience along with the sorry image
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sorry for the inconvenience',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'images/sorry.png',
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
