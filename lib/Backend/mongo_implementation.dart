import 'package:mongo_dart/mongo_dart.dart';
import 'user.dart';
Future<Db> getConnection() async{
  var db = await Db.create("mongodb+srv://KGB_Tech:KGB_Tech@cyberwatch.5ewsz.mongodb.net/myFirstDatabase?retryWrites=true&w=majority");
  await db.open();
  return db;
}
Future<User> registerUserAccount(User user) async{
  var db = await Db.create("mongodb+srv://user:user@cyberwatch.5ewsz.mongodb.net/DevelopmentDatabase?retryWrites=true");
  await db.open();
  var usersAccountCollection = db.collection('user_accounts');
  await usersAccountCollection.insert({
    '_id': user.id,
    'name': user.fullName,
    'email': user.email,
    'country': user.country,
    "dob": user.dateOfBirth
  });
  return user;
}

Future<User> loginUserAccount(String id) async{
  var db = await Db.create("mongodb+srv://user:user@cyberwatch.5ewsz.mongodb.net/DevelopmentDatabase?retryWrites=true");
  await db.open();
  var usersAccountCollection = db.collection('user_accounts');
  var userDocument = await usersAccountCollection.findOne(where.eq("_id", id));
  User user = User();
  user.id = userDocument!['_id'];
  user.fullName = userDocument['name'];
  user.email = userDocument['email'];
  user.country = userDocument['country'];
  user.dateOfBirth = userDocument['dob'];
  return user;
}