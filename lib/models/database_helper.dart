import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/models/task.dart';

class DatabaseHelper {
  Database db;
  static const String _todoTable = 'ToDoTable';
  static const String _title = 'title';
  static const String _isDone = 'isDone';
  static const String _parent = 'parent';
  static final DatabaseHelper dbHelper = DatabaseHelper();

  Future<Database> get database async {
    if (db != null) {
      return db;
    } else {
      return await initDatabase();
    }
  }

  Future<Database> initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), 'to_do_data.db'),
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $_todoTable(
          $_title TEXT,
          $_isDone BOOLEAN,
          $_parent TEXT
        )
      ''');
    }, version: 1);
  }

  dynamic addTask(Task task) async {
    final db = await database;
    var res = await db.rawInsert('''
      INSERT INTO $_todoTable(
        $_title,
        $_isDone,
        $_parent
      ) VALUES(
        ?,?,?
      )
    ''', [task.title, task.isDone, task.parent]);
    return res;
  }

  Future<dynamic> getTasks() async {
    final db = await database;
    var res = db.query(_todoTable);
    return res ?? 'Data not found';
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    var res = db.rawUpdate('''
      UPDATE $_todoTable
      SET $_isDone = ?
      WHERE $_title = ? AND $_parent = ?
    ''', [task.isDone ? 1 : 0, task.title, task.parent]);
  }

  Future<void> deleteTask(Task task) async {
    final db = await database;
    var res = db.rawDelete('''
      DELETE FROM $_todoTable
      WHERE $_title = ? AND $_parent = ?
    ''', [task.title, task.parent]);
  }
}
