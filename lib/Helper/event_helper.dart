import 'package:path_provider/path_provider.dart';
import 'package:personaltaskmanagersystem/Models/event_model.dart';
import 'package:personaltaskmanagersystem/Models/tasks_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class EventDBHelper {

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
    String path = join(documentDirectory.path, 'events.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate );
    return db;
  }

  _onCreate(Database db, int version) async {
    await  db.execute(
      "CREATE TABLE events (id INTEGER PRIMARY KEY AUTOINCREMENT, eventName TEXT NOT NULL, address TEXT NOT NULL)",
    );
  }


  Future<EventsModel> insert(EventsModel eventsModel) async {
    var dbClient = await db;
    await dbClient!.insert('events', eventsModel.toMap());
    return eventsModel;
  }


  Future<List<EventsModel>> getEventsList() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult = await dbClient!.query('events' );
    return queryResult.map((e) => EventsModel.fromMap(e)).toList();

  }

  // Deleting Data From Database
  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient!.delete(
        'events',
        where: 'id = ?',
        whereArgs: [id]
    );
  }

  // Update Data In Database
  Future<int> update(EventsModel eventsModel) async{
    var dbClient = await db;
    return await dbClient!.update(
        "events",
        eventsModel.toMap(),
        where: 'id = ?',
        whereArgs: [eventsModel.id]
    );
  }

}