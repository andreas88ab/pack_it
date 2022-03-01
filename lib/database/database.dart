import 'dart:async';
import 'dart:io';
import 'package:pack_it_v1/model/story.dart';
import 'package:pack_it_v1/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseClient {
  late Database _db;

  Future create() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "tradecraft.db");

    _db = await openDatabase(dbPath, version: 1,
        onCreate: this._create);
  }

  Future _create(Database db, int version) async {
    await db.execute("""
            CREATE TABLE story (
              id INTEGER PRIMARY KEY, 
              user_id INTEGER NOT NULL,
              title TEXT NOT NULL,
              body TEXT NOT NULL,
              FOREIGN KEY (user_id) REFERENCES user (id) 
                ON DELETE NO ACTION ON UPDATE NO ACTION
            )""");

    await db.execute("""
            CREATE TABLE user (
              id INTEGER PRIMARY KEY,
              username TEXT NOT NULL UNIQUE
            )""");
  }

  Future<User> upsertUser(User user) async {
    var count = Sqflite.firstIntValue(await _db.rawQuery("SELECT COUNT(*) FROM user WHERE username = ?", [user.username]));
    if (count == 0) {
      return new User(await _db.insert("user", user.toMap()), user.username);
    } else {
      await _db!.update("user", user.toMap(), where: "id = ?", whereArgs: [user.id]);
    }

    return user;
  }

  Future<Story> upsertStory(Story story) async {
    if (story.id == null) {
      story.id = await _db.insert("story", story.toMap());
    } else {
      await _db.update("story", story.toMap(), where: "id = ?", whereArgs: [story.id]);
    }

    return story;
  }
}

