import 'package:path_provider/path_provider.dart';
import 'package:personaltaskmanagersystem/Models/friends_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {

  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate );
    return db;
  }

  _onCreate(Database db, int version) async {
    await  db.execute(
      "CREATE TABLE friends (id INTEGER PRIMARY KEY AUTOINCREMENT, fName TEXT NOT NULL, lName TEXT NOT NULL, age INTEGER NOT NULL, address TEXT NOT NULL, gender TEXT NOT NULL)",
    );
  }


  Future<FriendsModel> insert(FriendsModel friendsModel) async {
    var dbClient = await db;
    await dbClient!.insert('friends', friendsModel.toMap());
    return friendsModel;
  }


  Future<List<FriendsModel>> getCartListWithUserId() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult = await dbClient!.query('friends' );
    return queryResult.map((e) => FriendsModel.fromMap(e)).toList();

  }

  // Deleting Data From Database
  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient!.delete(
      'friends',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  // Update Data In Database
  Future<int> update(FriendsModel friendsModel) async{
    var dbClient = await db;
    return await dbClient!.update(
      "friends",
      friendsModel.toMap(),
      where: 'id = ?',
      whereArgs: [friendsModel.id]
    );
  }

}