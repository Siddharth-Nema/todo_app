import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/database_helper.dart';
import 'package:todoapp/models/project.dart';
import 'package:todoapp/models/task.dart';

class ToDoData extends ChangeNotifier {
  List<Task> tasks = [];
  List<Project> projects = [];

  bool addTask(Task task) {
    print('tasks updated');
    if (task.title == '') {
      return false;
    }
    for (Task prevTask in tasks) {
      if (prevTask.title == task.title) {
        return false;
      }
    }
    tasks.add(task);
    addtoDatabase(task);
    notifyListeners();
    return true;
  }

  void addtoDatabase(Task task) {
    DatabaseHelper.dbHelper.addTask(task);
  }

  void deleteTask(Task task) {
    DatabaseHelper.dbHelper.deleteTask(task);
    tasks.remove(task);
    notifyListeners();
  }

  void toggleCheck(Task task) async {
    task.toggleCheck();
    DatabaseHelper.dbHelper.updateTask(task);
    notifyListeners();
  }

  void getData() async {
    var response = await DatabaseHelper.dbHelper.getTasks();
    var data = json.decode(response.body);
    tasks = [];
    projects = [];
    print(data);
    for (var todo in data) {
      print(todo);
      tasks.add(Task(
          title: todo['title'],
          isDone: todo['isCompleted'],
          parent: 'NONE',
          id: todo["_id"]));
    }

    response = await DatabaseHelper.dbHelper.getProjects();
    data = json.decode(response.body);

    for (var project in data) {
      var list =
          Project(tasks: [], title: project['title'], id: project['_id']);
      for (var todo in project['tasks']) {
        if (todo['title'] == null) {
          continue;
        }
        list.addTask(Task(
            title: todo['title'],
            isDone: todo['isCompleted'],
            id: todo['_id']));
      }

      print(list.id);
      projects.add(list);
    }

    notifyListeners();
  }

  void clearData() {
    tasks.clear();
    projects.clear();
    notifyListeners();
  }

  bool addProject(Project project) {
    if (project.title == '') {
      return false;
    }
    for (Project prevProject in projects) {
      if (prevProject.title == project.title) {
        return false;
      }
    }

    projects.add(project);
    DatabaseHelper.dbHelper.addProject(project);
    notifyListeners();
    return true;
  }

  void deleteProject(Project project) {
    print(project.id);
    DatabaseHelper.dbHelper.deleteProject(project);
    projects.remove(project);
    notifyListeners();
  }

  void toggleTaskfromProject(Task task, String projectID) {
    task.toggleCheck();
    DatabaseHelper.dbHelper.updateTaskInProject(task, projectID);
    notifyListeners();
  }

  bool addToProject(Task task, Project project) {
    if (task.title == '' || project.id == null) {
      return false;
    }
    for (Task prevTask in project.tasks) {
      if (prevTask.id == task.id) {
        return false;
      }
    }
    project.tasks.add(task);
    DatabaseHelper.dbHelper.addTaskToProject(task, project.id ?? '');
    notifyListeners();
    return true;
  }

  void deletefromProject(Task task, Project project) {
    DatabaseHelper.dbHelper.deleteTaskFromProject(task, project.id ?? '');
    project.tasks.remove(task);
    notifyListeners();
  }
}
