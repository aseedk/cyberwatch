import 'package:twitter_login/twitter_login.dart';
import 'package:dart_twitter_api/twitter_api.dart';

String authToken="";
String authTokenSecret="";

Future loginTwitter() async {
  final twitterLogin = TwitterLogin(
    apiKey: "4aNp2JGbx8eDXMvJzhjyWU8lf",
    apiSecretKey: "QgJbqWNRMjGamwDLbvaim9z3HcZe4OVRjFDnHdwMMAXDhHci0l",
    redirectURI: 'cyberwatch://',
  );
  final authResult = await twitterLogin.login();
  switch (authResult.status) {
    case TwitterLoginStatus.loggedIn:
      print('====== Login success ======');
      print(authResult.authToken);
      authToken = authResult.authToken!;
      authTokenSecret = authResult.authTokenSecret!;
      print(authResult.authTokenSecret);
      break;
    case TwitterLoginStatus.cancelledByUser:
      print('====== Login cancel ======');
      break;
    case TwitterLoginStatus.error:
    case null:
      print('====== Login error ======');
      break;
  }
}
final twitterApi = TwitterApi(
  client: TwitterClient(
    consumerKey: '4aNp2JGbx8eDXMvJzhjyWU8lf',
    consumerSecret: 'QgJbqWNRMjGamwDLbvaim9z3HcZe4OVRjFDnHdwMMAXDhHci0l',
    token: authToken,
    secret: authTokenSecret,
  ),
);
Future<void> getUserMentions() async{
  try {
    final mentionTimeline = await twitterApi.timelineService.mentionsTimeline(
      count: 10,
    );
    for (var tweet in mentionTimeline) {
      print(tweet.fullText);
    }
  }catch (error){
    print('Error');
  }
}
Future<void> getUserTweets() async{
  try {
    final userTimeline = await twitterApi.timelineService.userTimeline(
      count: 10,
    );
    for (var tweet in userTimeline) {
      print(tweet.fullText);
    }
  }catch (error){
    print('Error');
  }
}