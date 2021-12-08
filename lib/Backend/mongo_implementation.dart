import 'package:mongo_dart/mongo_dart.dart';
import 'user.dart';
Future<Db> getConnection() async{
  var db = await Db.create("mongodb+srv://KGB_Tech:KGB_Tech@cyberwatch.5ewsz.mongodb.net/myFirstDatabase?retryWrites=true&w=majority");
  await db.open();
  return db;
}
void registerUserAccount(User user) async{
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
  print('User Registered Succesfully');
}