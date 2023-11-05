import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/models/task.dart';
import 'package:http/http.dart' as http;

class DatabaseHelper {
  late Database db;
  static const String _todoTable = 'ToDoTable';
  static const String _title = 'title';
  static const String _isDone = 'isDone';
  static const String _parent = 'parent';
  static final DatabaseHelper dbHelper = DatabaseHelper();

  // Future<Database> get database async {
  //   if (db != null) {
  //     return db;
  //   } else {
  //     return await initDatabase();
  //   }
  // }

  // Future<Database> initDatabase() async {
  //   return await openDatabase(join(await getDatabasesPath(), 'to_do_data.db'),
  //       onCreate: (db, version) async {
  //     await db.execute('''
  //       CREATE TABLE $_todoTable(
  //         $_title TEXT,
  //         $_isDone BOOLEAN,
  //         $_parent TEXT
  //       )
  //     ''');
  //   }, version: 1);
  // }

  dynamic addTask(Task task) async {
    final response = await http
        .post(Uri.parse('https://todo-api-wr5u.onrender.com/todo/add'), body: {
      'title': task.title,
      'isCompleted': task.isDone.toString(),
    });

    print(response.body);
    var data = json.decode(response.body);
    String id = data["_id"];

    task.addID(id);

    print("Adding Task");
    return response;
  }

  Future<http.Response> getTasks() async {
    print('Getting data');
    return http.get(Uri.parse('https://todo-api-wr5u.onrender.com/todo/'));
  }

  Future<void> updateTask(Task task) async {
    print(task.id);
    final response = await http.put(
        Uri.parse('https://todo-api-wr5u.onrender.com/todo'),
        body: {'id': task.id, 'status': task.isDone.toString()});

    print(response.body);
  }

  Future<void> deleteTask(Task task) async {
    final response = await http.delete(
        Uri.parse('https://todo-api-wr5u.onrender.com/todo/${task.id}'));

    print(response.body);
  }
}
