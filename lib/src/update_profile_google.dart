import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:cyberwatch/src/connect_social_media_accounts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';

class UpdateProfileGoogle extends StatefulWidget {
  const UpdateProfileGoogle({Key? key, required this.user}) : super(key: key);
  final DocumentSnapshot user;
  @override
  _UpdateProfileGoogleState createState() => _UpdateProfileGoogleState();
}

class _UpdateProfileGoogleState extends State<UpdateProfileGoogle> {
  final countryController = TextEditingController();
  final countryCodeController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void initState(){
    genderController.text = "Male";
    countryCodeController.text = "init";
    super.initState();
  }
  @override
  void dispose() {
    countryController.dispose();
    genderController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
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
                  "Update Profile",
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
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: const Text(
                        "Update profile information",
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
                      margin: const EdgeInsets.only(left: 20, right: 5, top: 5, bottom: 5),
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
                          if (countryController.text.isNotEmpty &&
                              genderController.text.isNotEmpty &&
                              dateOfBirthController.text.isNotEmpty
                          ){
                            CollectionReference users = FirebaseFirestore
                                .instance.collection('users');
                            users
                                .doc(widget.user.id)
                                .update({
                                  'country': countryController.text,
                                  'gender': genderController.text,
                                  'dateOfBirth': dateOfBirthController.text
                                })
                                .then((value) => {
                                    Fluttertoast.showToast(
                                        msg: "Account Information Updated",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (context) => ConnectSocialMediaAccount(user: widget.user),
                                      ),
                                    )
                                  })
                                .catchError((error) => {
                                      Fluttertoast.showToast(
                                          msg: error.toString(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0)
                                    });
                          }
                        },
                        child: const Text("Update Profile"),
                      ),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
