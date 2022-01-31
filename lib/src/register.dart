import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cyberwatch/src/login.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class RegisterComponent extends StatefulWidget {
  const RegisterComponent({Key? key}) : super(key: key);

  @override
  _RegisterComponentState createState() => _RegisterComponentState();
}
class _RegisterComponentState extends State<RegisterComponent> {
  bool _obscureText = true;
  bool _nameError = false;
  bool _emailError = false;
  bool _passwordError = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final countryController = TextEditingController();
  final countryCodeController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController();


  bool nameCheck(var testValue){
    RegExp regExp = RegExp(r'^[a-zA-Z]{2,40}( [a-zA-Z]{2,40})+$');
    return regExp.hasMatch(testValue);
  }
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
  void initState(){
    genderController.text = "Male";
    countryCodeController.text = "init";
    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    countryController.dispose();
    genderController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: MAKE UI BETTER
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:
        Column(
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
                      Icons.navigate_before,
                      color: Colors.white,
                      size: 30,
                    ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginComponent(),
                      ),
                    );
                    },
                  ),
                  const Text(
                    "Register",
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
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: const Text(
                        "Register your account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: TextField(
                        controller: nameController,
                        onChanged: (text) async {
                          await Future.delayed(const Duration(milliseconds: 1000), () {});
                          if(text == ""){
                            setState(() {
                              _nameError = false;
                            });
                          }
                          else if (!nameCheck(text)) {
                            setState(() {
                              _nameError = true;
                            });
                          }else{
                            setState(() {
                              _nameError = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Full Name',
                            hintText: "Enter Your First and Last Name",
                            errorText: _nameError ? "Numbers & Special Characters are not allowed": null,
                            icon: const Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Icon(Icons.person))
                        ),
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
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: TextField(
                        controller: countryController,
                        onTap: (){
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              countryController.text = country.name;
                              countryCodeController.text = country.countryCode.toLowerCase();
                            },
                          );
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Country',
                          icon: const Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Icon(Icons.add_location_alt_outlined)
                              // TODO: ADD COUNTRY FLAG
                          ),
                          suffixIcon: Container(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'flags/' + countryCodeController.text + '.png',
                              width: 50,
                              height: 50,
                            ),
                          )
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: TextField(
                        controller: dateOfBirthController,
                        onTap: (){
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              maxTime: DateTime.now(),
                              onChanged: (date) {
                              }, onConfirm: (date) {
                                dateOfBirthController.text = date.day.toString()
                                    + "-" + date.month.toString() + "-" + date.year.toString();
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                        readOnly: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Date Of Birth',
                            icon: Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Icon(Icons.date_range)
                            ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: GenderPickerWithImage(
                        verticalAlignedText: false,
                        showOtherGender: true,
                        selectedGender: Gender.Male,
                        selectedGenderTextStyle: const TextStyle(
                            color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
                        unSelectedGenderTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),

                        equallyAligned: true,
                        animationDuration: const Duration(milliseconds: 300),
                        isCircular: true,
                        // default : true,
                        opacityOfGradient: 0.4,
                        padding: const EdgeInsets.all(3),
                        size: 75, onChanged: (Gender? value) {
                          genderController.text = value.toString().split('.')[1];
                      }, //default : 40
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async{
                          if (!_nameError &&
                                !_emailError &&
                              !_passwordError &&
                              nameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty &&
                              countryController.text.isNotEmpty &&
                              genderController.text.isNotEmpty &&
                              dateOfBirthController.text.isNotEmpty
                          ){
                            CollectionReference users = FirebaseFirestore.instance.collection('users');
                            try {
                              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                              users
                                  .doc(userCredential.user!.uid)
                                  .set({
                                'name': nameController.text,
                                'email': emailController.text,
                                'gender': genderController.text,
                                'country': countryController.text,
                                'dateOfBirth': dateOfBirthController.text,
                                'facebookAccessToken': '',
                                'twitterAccessToken': '',
                                'twitterAccessSecret': '',
                                'verified': false
                              }).then((value) => Fluttertoast.showToast(
                                  msg: "Account Registered Successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              )).catchError((error) => Fluttertoast.showToast(
                                  msg: error.toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              ));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                Fluttertoast.showToast(
                                    msg: "Password provided is weak",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                              else if (e.code == 'email-already-in-use') {
                                Fluttertoast.showToast(
                                    msg: "Email already in use",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            } catch (e) {
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
                          }else{
                            Fluttertoast.showToast(
                                msg: "Some Fields are Empty",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        },
                        child: const Text("Register"),
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
                              builder: (context) => const LoginComponent(),
                            ),
                          );
                        },
                        child: const Text("Already have an account? Sign in"),
                      )
                    )
                  ],
                ),
              )
            )
          ],
        ),
    );
  }
}
