import 'login.dart';
import 'package:flutter/material.dart';
import '../Backend/user.dart';
import '../Backend/flutter_fire.dart';
import 'connect_social_media_accounts.dart';
import '../Backend/mongo_implementation.dart';
import '../Backend/input_file.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final nameTextFieldController = TextEditingController();
    final emailTextFieldController = TextEditingController();
    final passwordTextFieldController = TextEditingController();
    final countryTextFieldController = TextEditingController();
    final dateOfBirthTextFieldController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        // height: MediaQuery.of(context).size.height,
        // width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                ClipRRect(
                  //give black color to border of the image
                  child: Image.asset(
                    'images/cyberwatch1.png',
                    height: 200,
                    width: 300,
                  ),
                ),
                const Text(
                  "SignUp",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                InputFile(
                  label: "Full Name",
                  labelText: '',
                  controller: nameTextFieldController
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFile(
                    label: "Email",
                    labelText: '',
                    controller: emailTextFieldController),
                const SizedBox(
                  height: 15,
                ),
                InputFile(
                    label: "Password",
                    obscureText: true,
                    labelText: '',
                    controller: passwordTextFieldController),
                const SizedBox(
                  height: 15,
                ),
                InputFile(
                  label: "Country",
                  labelText: '',
                  controller: countryTextFieldController
                ),
                const SizedBox(
                  height: 15,
                ),
                //input field to enter the date of birth
                InputFile(
                  label: "Date of birth",
                  obscureText: false,
                  labelText: '',
                  controller: dateOfBirthTextFieldController
                  //date picker to select the date of birth
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
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
                        User user= User();
                        user.fullName = nameTextFieldController.text;
                        user.email = emailTextFieldController.text;
                        user.password = passwordTextFieldController.text;
                        user.country = countryTextFieldController.text;
                        user.dateOfBirth = dateOfBirthTextFieldController.text;
                        var uid = await registerUser(user.email, user.password);
                        switch(uid) {
                          case 'The password provided is too weak.': {  print('The password provided is too weak.'); }
                          break;

                          case 'The account already exists for that email.': {  print('The account already exists for that email.'); }
                          break;

                          default: {
                            user.id = uid;
                            registerUserAccount(user);
                            print(user.toString()); }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConnectSocialMediaView(),
                            ),
                          );
                          break;
                        }

                      }, //add functionality for the signup button here
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
                      height: 20,
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed:
                          () {},
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
                            "Signup with Google",
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
                        builder: (context) => const LoginView(),
                      ),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Signin",
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
      ),
    );
  }
}
