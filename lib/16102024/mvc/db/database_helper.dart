// db/database_helper.dart

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'logdb.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE logs (
            id INTEGER PRIMARY KEY,
            path TEXT UNIQUE
          )
        ''');
      },
    );
  }

  Future<void> saveFilePath(String path) async {
    final db = await database;
    await db.insert(
      'logs',
      {'path': path},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<bool> isFileSaved(String path) async {
    final db = await database;
    final result = await db.query(
      'logs',
      where: 'path = ?',
      whereArgs: [path],
    );
    return result.isNotEmpty;
  }
}
