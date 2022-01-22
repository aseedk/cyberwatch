import 'package:cyberwatch/Backend/user.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:dart_twitter_api/twitter_api.dart';

String authToken="";
String authTokenSecret="";

Future<List<String?>> loginTwitter() async {
  final twitterLogin = TwitterLogin(
    apiKey: "4aNp2JGbx8eDXMvJzhjyWU8lf",
    apiSecretKey: "QgJbqWNRMjGamwDLbvaim9z3HcZe4OVRjFDnHdwMMAXDhHci0l",
    redirectURI: 'cyberwatch://',
  );
  final authResult = await twitterLogin.login();
  switch (authResult.status) {
    case TwitterLoginStatus.loggedIn:
      print('====== Login success ======');
      authToken = authResult.authToken!;
      authTokenSecret = authResult.authTokenSecret!;
      print(authResult.authToken);
      print(authResult.authTokenSecret);
      final List<String?> twitterUser = [];
      twitterUser.add(authResult.authToken);
      twitterUser.add(authResult.authTokenSecret);
      //break;
      return twitterUser;
    case TwitterLoginStatus.cancelledByUser:
      print('====== Login cancel ======');
      //break;
      return ['Cancel'];
    case TwitterLoginStatus.error:
    case null:
      print('====== Login error ======');
      //break;
      return ['Error'];
  }
}

Future<void> connectTwitterAPI(String authToken, String authTokenSecret)async {
  authToken = authToken;
  authTokenSecret = authTokenSecret;
}

final twitterApi = TwitterApi(
  client: TwitterClient(
    consumerKey: '4aNp2JGbx8eDXMvJzhjyWU8lf',
    consumerSecret: 'QgJbqWNRMjGamwDLbvaim9z3HcZe4OVRjFDnHdwMMAXDhHci0l',
    token: authToken,
    secret: authTokenSecret,
  ),
);
Future<String> getUserMentions(CyberWatchUser user) async{
  try {
    final twitterApiTTest = TwitterApi(
      client: TwitterClient(
        consumerKey: '4aNp2JGbx8eDXMvJzhjyWU8lf',
        consumerSecret: 'QgJbqWNRMjGamwDLbvaim9z3HcZe4OVRjFDnHdwMMAXDhHci0l',
        token: user.twitterAccessToken,
        secret: user.twitterAccessSecret,
      ),
    );
    final mentionTimeline = await twitterApiTTest.timelineService.mentionsTimeline(
      count: 10,
    );
    String tweets = "";
    for (var tweet in mentionTimeline) {
      tweets = tweets + tweet.fullText.toString() +"\n";
    }
    print(tweets);
    return tweets;
  }catch (error){
    print('Error');
    return "Error";
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