import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<void> loginFacebook() async{
  final LoginResult result = await FacebookAuth.instance.login();
  if (result.status == LoginStatus.success) {
    // you are logged
    final AccessToken accessToken = result.accessToken!;
    print(accessToken);
  } else {
    print(result.status);
    print(result.message);
  }
}

Future<void> checkUserFacebook() async{
  final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
// or FacebookAuth.i.accessToken
  if (accessToken != null) {
    print(accessToken.token);
  }
}

Future<void> logoutUserFacebook() async{
  await FacebookAuth.instance.logOut();
// or FacebookAuth.i.logOut();
}

Future<void> getUserDataFacebook() async{
  final userData = await FacebookAuth.instance.getUserData();
  print(userData);
}