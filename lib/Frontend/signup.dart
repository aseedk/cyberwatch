import 'login.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "SignUp",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an account, its FREE",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  inputFile(label: "Name", hintText: ''),
                  const SizedBox(
                    height: 15,
                  ),
                  inputFile(label: "Email", hintText: ''),
                  const SizedBox(
                    height: 15,
                  ),
                  inputFile(label: "Password", obscureText: true, hintText: ''),
                  const SizedBox(
                    height: 15,
                  ),
                  inputFile(
                    label: "Country",
                    hintText: '',
                  ),
                  const SizedBox(
                    height: 15,
                  ), //input field to enter the date of birth
                  inputFile(
                    label: "Date of Birth",
                    hintText: 'DD/MM/YYYY',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
                        onPressed:
                            () {}, //add functionality for the signup button here
                        color: const Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        //sized box is used to add space between the input fields
                        height: 20,
                      ),
                      //add login with google button here
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed:
                            () {}, //add functionality for the signup button here
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        child: const Text(
                          "Signup With Google",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const loginPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Already have an account? Sign In",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  datePicker(
      {dateFormat,
      required DateTime firstDate,
      required DateTime lastDate,
      required DateTime initialDate,
      required Null Function(date) onDateChanged}) {}

  dateFormat(String s) {}
}

mixin date {}
