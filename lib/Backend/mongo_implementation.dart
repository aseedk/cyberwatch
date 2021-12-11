import 'package:mongo_dart/mongo_dart.dart';
import 'user.dart';
Future<Db> getConnection() async{
  var db = await Db.create("mongodb+srv://KGB_Tech:KGB_Tech@cyberwatch.5ewsz.mongodb.net/myFirstDatabase?retryWrites=true&w=majority");
  await db.open();
  return db;
}
Future<CyberWatchUser> registerUserAccount(CyberWatchUser user) async{
  var db = await Db.create("mongodb+srv://user:user@cyberwatch.5ewsz.mongodb.net/DevelopmentDatabase?retryWrites=true");
  await db.open();
  var usersAccountCollection = db.collection('user_accounts');
  await usersAccountCollection.insert({
    '_id': user.id,
    'name': user.fullName,
    'email': user.email,
    'country': user.country,
    'dob': user.dateOfBirth,
    'facebookAccessToken': "",
    'twitterAccessToken': "",
    'twitterAccessSecret': ""
  });
  return user;
}

Future<CyberWatchUser> loginUserAccount(String id) async{
  var db = await Db.create("mongodb+srv://user:user@cyberwatch.5ewsz.mongodb.net/DevelopmentDatabase?retryWrites=true");
  await db.open();
  var usersAccountCollection = db.collection('user_accounts');
  var userDocument = await usersAccountCollection.findOne(where.eq("_id", id));
  CyberWatchUser user = CyberWatchUser();
  user.id = userDocument!['_id'];
  user.fullName = userDocument['name'];
  user.email = userDocument['email'];
  user.country = userDocument['country'];
  user.dateOfBirth = userDocument['dob'];
  user.facebookAccessToken = userDocument['facebookAccessToken'];
  user.twitterAccessToken = userDocument['twitterAccessToken'];
  user.twitterAccessSecret = userDocument['twitterAccessSecret'];
  return user;
}
Future<void> registerUserAccountGoogle(CyberWatchUser user) async{
  var db = await Db.create("mongodb+srv://user:user@cyberwatch.5ewsz.mongodb.net/DevelopmentDatabase?retryWrites=true");
  await db.open();
  var usersAccountCollection = db.collection('user_accounts');
  var userDocument = await usersAccountCollection.findOne(where.eq("_id", user.id));
  if (userDocument == null){
    print('Registering User');
    registerUserAccount(user);
  }
}
Future<void> linkFacebookAccount(CyberWatchUser user) async{
  var db = await Db.create("mongodb+srv://user:user@cyberwatch.5ewsz.mongodb.net/DevelopmentDatabase?retryWrites=true");
  await db.open();
  var usersAccountCollection = db.collection('user_accounts');
  usersAccountCollection.updateOne(where.eq('_id', user.id), modify.set('facebookAccessToken', user.facebookAccessToken));
}
Future<void> linkTwitterAccessTokenWithAccount(CyberWatchUser user) async{
  var db = await Db.create("mongodb+srv://user:user@cyberwatch.5ewsz.mongodb.net/DevelopmentDatabase?retryWrites=true");
  await db.open();
  var usersAccountCollection = db.collection('user_accounts');
  usersAccountCollection.updateOne(where.eq('_id', user.id), modify.set('twitterAccessToken', user.twitterAccessToken));
}

Future<void> linkTwitterAccessSecretWithAccount(CyberWatchUser user) async{
  var db = await Db.create("mongodb+srv://user:user@cyberwatch.5ewsz.mongodb.net/DevelopmentDatabase?retryWrites=true");
  await db.open();
  var usersAccountCollection = db.collection('user_accounts');
  usersAccountCollection.updateOne(where.eq('_id', user.id), modify.set('twitterAccessSecret', user.twitterAccessSecret));
}