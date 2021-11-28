bool alphabeticCheck(var testValue){
  RegExp regExp = RegExp(r"[a-zA-Z][a-zA-Z ]+",
    caseSensitive: false);
  return regExp.hasMatch(testValue);
}
bool emailCheck(var testValue){
  String regex = r'/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i';
  RegExp regExp = RegExp(regex,
      caseSensitive: false);
  return regExp.hasMatch(testValue);
}

bool passwordCheck(var testValue) {
  String regex = r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$";
  RegExp regExp = RegExp(regex,
      caseSensitive: false);
  return regExp.hasMatch(testValue);
}