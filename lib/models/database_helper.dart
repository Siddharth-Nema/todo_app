import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/models/project.dart';
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
      'userID': FirebaseAuth.instance.currentUser!.uid,
    });

    print(response.body);
    var data = json.decode(response.body);
    String id = data["_id"];

    task.addID(id);

    print("Adding Task");
    return response;
  }

  dynamic addProject(Project project) async {
    final response = await http.post(
        Uri.parse('https://todo-api-wr5u.onrender.com/project/add'),
        body: {
          'title': project.title,
          'userID': FirebaseAuth.instance.currentUser!.uid,
        });

    print(response.body);
    // var data = json.decode(response.body);
    // String id = data["_id"];

    //project.addID(id);

    //print("Adding Task");
    return response;
  }

  Future<http.Response> getTasks() async {
    print('Getting data');
    return http.get(Uri.parse(
        'https://todo-api-wr5u.onrender.com/todo/${FirebaseAuth.instance.currentUser!.uid}'));
  }

  Future<http.Response> getProjects() async {
    print('Getting Projects');
    return http.get(Uri.parse(
        'https://todo-api-wr5u.onrender.com/project/${FirebaseAuth.instance.currentUser!.uid}'));
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

  Future<void> deleteProject(Project project) async {
    final response = await http.delete(
        Uri.parse('https://todo-api-wr5u.onrender.com/project/${project.id}'));

    print(response.body);
  }

  Future<void> configurUser() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final response = await http.post(
          Uri.parse('https://todo-api-wr5u.onrender.com/user/configureUser'),
          body: {
            "name": _auth.currentUser?.displayName ?? "",
            "email": _auth.currentUser?.email ?? "",
            "phone": _auth.currentUser!.phoneNumber,
            "fcmToken": _auth.currentUser!.uid
          });

      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserDetails(String name, String email) async {
    await http
        .post(Uri.parse('https://todo-api-wr5u.onrender.com/user/updateUser'),
            body: {
              "name": name,
              "email": email,
            })
        .then((value) => print(value))
        .catchError((e) {
          print(e);
        });
  }

  Future<void> addTaskToProject(Task task, String projectID) async {
    final response = await http.post(
        Uri.parse('https://todo-api-wr5u.onrender.com/project/addToProject'),
        body: {
          'projectID': projectID,
          'userID': FirebaseAuth.instance.currentUser!.uid,
          'title': task.title,
        });

    var data = json.decode(response.body);
    String id = data["_id"];

    task.addID(id);
  }

  Future<void> updateTaskInProject(Task task, String projectID) async {
    final response = await http.post(
        Uri.parse('https://todo-api-wr5u.onrender.com/project/updateInProject'),
        body: {
          'taskID': task.id,
          'taskStatus': task.isDone.toString(),
          'projectID': projectID
        });

    print(response.body);
  }

  Future<void> deleteTaskFromProject(Task task, String projectID) async {
    final response = await http.post(
        Uri.parse(
            'https://todo-api-wr5u.onrender.com/project/removeTaskFromProject'),
        body: {'projectID': projectID, 'taskID': task.id});

    print(response.body);
  }
}
