import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  // Create a singleton
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'app.db');

    return await openDatabase(path, version: 1, onOpen: (db) async {
    }, onCreate: (Database db, int version) async {
      await db.execute('''
                CREATE TABLE people(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT,
                    height INTEGER,
                    mass INTEGER,
                    hair_color TEXT,
                    skin_color TEXT,
                    eye_color TEXT,
                    birth_year TEXT,
                    gender TEXT,
                    homeworld TEXT,
                    films TEXT,
                    species TEXT,
                    vehicles TEXT,
                    starships TEXT,
                    created TEXT,
                    url TEXT
                )
            ''');
    });
  }
}