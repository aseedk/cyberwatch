class UserBuilder{
  late String _firstName;
  late String _lastName;
  late String _email;
  late DateTime _dateOfBirth ;
  late String _facebookAccessToken;
  UserBuilder();

  String get facebookAccessToken => _facebookAccessToken;
  set facebookAccessToken(var value) {
    _facebookAccessToken = value;
  }

  DateTime get dateOfBirth => _dateOfBirth;
  set dateOfBirth(var value) {
    _dateOfBirth = value;
  }

  String get email => _email;
  set email(var value) {
    _email = value;
  }

  String get lastName => _lastName;
  set lastName(var value) {
    _lastName = value;
  }

  String get firstName => _firstName;
  set firstName(var value) {
    _firstName = value;
  }
  User build(){
    return User(this);
  }
}


class User {
  late String _firstName;
  late String _lastName;
  late String _email;
  late DateTime _dateOfBirth ;
  late String _facebookAccessToken;
  User(UserBuilder builder){
    _firstName = builder._firstName;
    _lastName = builder._lastName;
    _email = builder._email;
    _dateOfBirth = builder._dateOfBirth;
    _facebookAccessToken = builder._facebookAccessToken;
  }
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  DateTime get dateOfBirth => _dateOfBirth;
  String get facebookAccessToken => _facebookAccessToken;
  @override
  String toString() {
    return 'User Name: $_firstName $_lastName\n'
        'Email: $_email '
        'DateOfBirth: $_dateOfBirth'
        'FacebookAccessToken: $_facebookAccessToken}';
  }
}