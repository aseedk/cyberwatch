import 'package:mongo_dart/mongo_dart.dart';

void getConnection(String url) async{
  var db = await Db.create("mongodb+srv://<user>:<password>@<host>:<port>/<database-name>?<parameters>");
  await db.open();
  print(db);
}