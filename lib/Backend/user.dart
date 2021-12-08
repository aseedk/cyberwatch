class CyberWatchUser {
  late String _id;
  late String _fullName;
  late String _email;
  late String _password = "";
  late String _country;
  late String _dateOfBirth;
  late bool _verified = true;
  late String _facebookAccessToken = "";
  late String _twitterAccessToken = "";
  late String _twitterAccessSecret = "";
  CyberWatchUser();
  String get id => _id;
  set id(var value) {
    _id = value;
  }
  String get facebookAccessToken => _facebookAccessToken;
  set facebookAccessToken(var value) {
    _facebookAccessToken = value;
  }

  String get dateOfBirth => _dateOfBirth;
  set dateOfBirth(var value) {
    _dateOfBirth = value;
  }

  String get email => _email;
  set email(var value) {
    _email = value;
  }

  String get fullName => _fullName;
  set fullName(var value) {
    _fullName = value;
  }

  String get password => _password;
  set password(var value) {
    _password = value;
  }
  String get country => _country;
  set country(var value) {
    _country = value;
  }

  bool get verified => _verified;
  set verified(var value) {
    _verified = value;
  }

  String get twitterAccessToken => _twitterAccessToken;
  set twitterAccessToken(var value) {
    _twitterAccessToken = value;
  }

  String get twitterAccessSecret => _twitterAccessSecret;
  set twitterAccessSecret(var value) {
    _twitterAccessSecret = value;
  }
  @override
  String toString() {
    return 'Name: $fullName\n'
        'id: $id\n'
        'Email: $email \n'
        'Password: $password\n'
        'Country: $country\n'
        'DateOfBirth: $dateOfBirth \n'
        'Verified: $verified \n'
        'FacebookAccessToken: $facebookAccessToken \n'
        'TwitterAccessToken: $twitterAccessToken \n'
        'TwitterAccessSecret: $twitterAccessSecret';
  }
  Map<String, dynamic> toJson() =>
      {
        'Name': fullName,
        'Email': email,
        'Password': password,
        'Country': country,
        'DateOfBirth': dateOfBirth,
        'Verified': verified,
        'FacebookAccessToken': facebookAccessToken,
        'TwitterAccessToken': twitterAccessToken,
        'TwitterAccessSecret': twitterAccessSecret
      };
}