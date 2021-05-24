import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/models/userModel.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initilazeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  _initilazeDatabase() async {
    Database _db;

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "appDB.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      // print("Creating new copy from asset");
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "usersDB.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      //print("Opening existing database");
    }
// open the database
    _db = await openDatabase(path, readOnly: false);
    return _db;
  }
    //------------------------------------------------------------------------------------
  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await _getDatabase();
    var result2 = await db.query("users");
    return result2;
  }
  Future<List<Users>> getUsersList() async {
    var dbUsers = await getUsers();
    var u = List<Users>();
    for (Map map in dbUsers) {
      u.add(Users.fromJson(map));
    }
    return u;
  }

  Future<int> insertM(Users u) async {
    Database db = await _getDatabase();
    var result = await db.insert("users", u.toJson());
      return result;

  }

  Future<int> deleteM(int id) async {
    Database db = await _getDatabase();
    var result =
    await db.delete("users", where: 'ID = ?', whereArgs: [id]);
    return result;
  }

  Future<int> updateM(Users u) async {
    Database db = await _getDatabase();
    var result = await db.update("users", u.toJson(),
        where: 'ID = ?', whereArgs: [u.id]);
    return result;
  }

}