import 'dart:io';
import 'user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UserHelper {
  final String databaseName = "MaoNaRoda.db";
  final int databaseVersion = 1;
  late Database db;

  open() async {
    Directory dbDir = await getApplicationDocumentsDirectory();
    String dbPath = join(dbDir.path, databaseName);
    db = await openDatabase(dbPath,
        version: databaseVersion, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY autoincrement, name TEXT, email TEXT, senha TEXT)");
    await db.execute(
        "insert into user(name, email, senha) values('adm', 'adm@adm', 'adm')");
  }

  Future<int> saveUser(User u) async {
    var dbClient = db;
    int res = await dbClient.insert("user", u.toMap());
    return res;
  }

  Future<bool> updateUser(User u) async {
    var dbClient = db;
    int res = await dbClient
        .update("user", u.toMap(), where: "id = ?", whereArgs: [u.id]);
    return res > 0 ? true : false;
  }

  Future<bool> deleteUser(User u) async {
    var dbClient = db;
    int res = await dbClient.rawDelete("delete from user where id = ?", [u.id]);
    return res > 0 ? true : false;
  }

  Future<User?> validateLogin(String email, String senha) async {
    var dbClient = db;
    User? user;
    List<Map> list = await dbClient.rawQuery(
        "select * from user where email = ? and senha = ?", [email, senha]);
    if (list.length > 0) {
      user = User(
        list[0]["id"],
        list[0]["name"],
        list[0]["email"],
        list[0]["senha"],
      );
    }
    return user;
  }
}
