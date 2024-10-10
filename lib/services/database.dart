import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _db;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get db async {
    if (_db != null) return _db!;

    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'MyPills3test.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT,
        password TEXT,
        salt TEXT
      )
    ''');
  }

  String generateSalt([int length = 16]) {
    final random = Random.secure();
    return base64.encode(List<int>.generate(length, (i) => random.nextInt(256)));
  } 

  String hashPassword(String password, String salt) {
    return sha256.convert(utf8.encode(password + salt.toString())).toString();
  }
}
