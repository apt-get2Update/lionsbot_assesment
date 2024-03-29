import 'user.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    final db = await openDatabase(inMemoryDatabasePath, version: 1,
        onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE user( name TEXT,username TEXT, password TEXT, pic TEXT)',
      );
      await db.insert('user', {
        "name": "Thirumurugan Mani",
        "username": "thiru",
        "password": "password",
        "pic": "https://avatars.githubusercontent.com/u/19830522"
      });
      await db.insert('user', {
        "name": "SathishKumar Thiyagarajan",
        "username": "sathish",
        "password": "password",
        "pic": "https://avatars.githubusercontent.com/u/1736813"
      });
      await db.insert('user', {
        "name": "Kiang Hong Law",
        "username": "kianghong",
        "password": "password",
        "pic": "https://avatars.githubusercontent.com/u/14790172"
      });
      await db.insert('user', {
        "name": "Khairul Syafiq",
        "username": "khairul",
        "password": "password",
        "pic":
            "https://media-exp2.licdn.com/dms/image/D5603AQEpjiB_4SY2ew/profile-displayphoto-shrink_400_400/0/1636116407686?e=1663200000&v=beta&t=IsEJdow-qX9sBzWNYjFGJZ33YLVJ4ugKcIGxDfD1XFw"
      });
      // khairul@lionsbot.com
    });
    return db;
  }

  Future<User> getUser(String username) async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient!
        .query("user", where: '"username" = ?', whereArgs: [username]);
    if (res.length > 0) {
      return Future<User>.value(User.map(res.first));
    } else {
      return Future<User>.error("Unable to find User");
    }
  }

  Future<User> checkUser(String username, String password) async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient!.query("user",
        where: '"username" = ? and "password"=?',
        whereArgs: [username, password]);
    if (res.length > 0) {
      return Future<User>.value(User.map(res.first));
    } else {
      return Future<User>.error("Unable to find User");
    }
  }

  Future<List<User>> getAllUser() async {
    var dbClient = await db;
    List<User> users = [];
    List<Map<String, dynamic>> res = await dbClient!.query("user");
    for (var row in res) {
      users.add(User.map(row));
    }
    return Future<List<User>>.value(users);
  }
}
