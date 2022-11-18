import 'dart:async';

import 'package:keyboard/core/abstracts/local_database.dart';
import 'package:keyboard/core/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase implements LocalDatabase{
  Database? _database;

  @override
  UserModel? user;

  Future<Database> get database async {
    if (_database != null) return _database!;

    await init();
    return _database!;
  }

  @override
  Future<void> init() async {
    _database = await initDB();
  }

  Future<Database> initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'ottaa_keyboard_database.db'),
      version: 1,
      onConfigure: _onConfigure,
      onUpgrade: _onUpgrade,
      onDowngrade: _onUpgrade,
      onCreate: _onCreate,
      onOpen: (db) async {
        _database = db;
        user = await getUser();
      },
    );
  }

  Future<void> _onConfigure(db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS user (
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT,
        photoUrl TEXT,
        language TEXT,
        keyboardLayout TEXT,
        fontSize TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.transaction((txn) {
      return _drop(txn, deleteUser: newVersion % 2 == 0);
    });

    await _onCreate(db, newVersion);
  }

  Future<void> _drop(Transaction db, {bool deleteUser = false}) async {
    if (deleteUser) db.execute('''DROP TABLE IF EXISTS user''');
  }

  @override
  Future<void> close() async {
    final db = await database;
    await db.transaction((txn) => _drop(txn, deleteUser: true));
  }

  @override
  Future<void> setUser(UserModel user) async {
    final db = await database;
    await db.delete('user');
    await db.insert('user', user.toMap());

    this.user = user;
  }

  @override
  Future<UserModel?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');

    if (maps.isEmpty) return null;

    return UserModel.fromMap(maps.first);
  }

  @override
  Future<void> deleteUser() async {
    final db = await database;
    await db.delete('user');

    user = null;
  }
}
