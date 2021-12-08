import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;

Future<String> loginFacebook() async{
  final LoginResult result = await FacebookAuth.instance.login();
  if (result.status == LoginStatus.success) {
    final AccessToken accessToken = result.accessToken!;
    return accessToken.token;
  } else {
    print(result.status);
    print(result.message);
    return "Failed Login";
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
Future<void> getUserPostsFacebook(String accessToken) async{
  final response = await http
      .get(Uri.parse("https://graph.facebook.com/v12.0/me?fields=posts&access_token="+ accessToken ));
  print(jsonDecode(response.body));
}
Future<void> getUserVideosFacebook(String accessToken) async{
  final response = await http
      .get(Uri.parse("https://graph.facebook.com/v12.0/me?fields=videos&access_token="+ accessToken ));
  print(jsonDecode(response.body));
}
Future<void> getUserPhotosFacebook(String accessToken) async{
  final response = await http
      .get(Uri.parse("https://graph.facebook.com/v12.0/me?fields=photos&access_token="+ accessToken ));
  print(jsonDecode(response.body));
}
