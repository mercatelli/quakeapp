import 'dart:async';
import 'dart:io';
import 'package:quakeapp/favorite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableFavorite = "favoriteTable";
  final String columnId = "id";
  final String columnPoster = "poster";
  final String columnTitle = "title";
  final String columnGenre = "genre";
  final String columnRelease = "release";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(
        documentDirectory.path, "maindb.db"); //home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  /*
     id | username | password
     ------------------------
     1  | Paulo    | paulo
     2  | James    | bond
   */

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableFavorite($columnId INTEGER PRIMARY KEY, $columnPoster TEXT, $columnTitle TEXT, $columnGenre TEXT, $columnRelease TEXT)");
  }

  //CRUD - CREATE, READ, UPDATE , DELETE

  //Insertion
  Future<int> saveFavorite(Favorite favorite) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableFavorite", favorite.toMap());
    return res;
  }

  //Get Users
  Future<List> getAllFavorites() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableFavorite");  // * means all, everything

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableFavorite"));
  }

  Future<Favorite> getFavorite(int id) async {
    var dbClient = await db;

    var result = await dbClient.rawQuery("SELECT * FROM $tableFavorite WHERE $columnId = $id");
    if (result.length == 0) return null;
    return new Favorite.fromMap(result.first);
  }

  Future<int> deleteFavorite(int id) async {
    var dbClient = await db;

    return await dbClient.delete(tableFavorite,
        where: "$columnId = ?", whereArgs: [id]);
  }


  Future<int> updateFavorite(Favorite user) async {
    var dbClient = await db;
    return await dbClient.update(tableFavorite,
        user.toMap(), where: "$columnId = ?", whereArgs: [user.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }


}
