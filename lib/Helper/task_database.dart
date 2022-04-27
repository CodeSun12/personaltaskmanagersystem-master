import 'package:path_provider/path_provider.dart';
import 'package:personaltaskmanagersystem/Models/tasks_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class TaskDBHelper {

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
    String path = join(documentDirectory.path, 'tasks.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate );
    return db;
  }

  _onCreate(Database db, int version) async {
    await  db.execute(
      "CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, taskName TEXT NOT NULL, address TEXT NOT NULL, description TEXT NOT NULL)",
    );
  }


  Future<TasksModel> insert(TasksModel tasksModel) async {
    var dbClient = await db;
    await dbClient!.insert('tasks', tasksModel.toMap());
    return tasksModel;
  }


  Future<List<TasksModel>> getTasksList() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult = await dbClient!.query('tasks' );
    return queryResult.map((e) => TasksModel.fromMap(e)).toList();

  }

  // Deleting Data From Database
  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient!.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [id]
    );
  }

  // Update Data In Database
  Future<int> update(TasksModel tasksModel) async{
    var dbClient = await db;
    return await dbClient!.update(
        "tasks",
        tasksModel.toMap(),
        where: 'id = ?',
        whereArgs: [tasksModel.id]
    );
  }

}