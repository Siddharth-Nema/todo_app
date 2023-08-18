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
    if (task.title == null || task.title == '') {
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
    var data = await DatabaseHelper.dbHelper.getTasks();
    for (var todo in data) {
      print(todo);
      if (todo['parent'] == 'NONE') {
        tasks.add(Task(
            title: todo['title'], isDone: todo['isDone'] == 1, parent: 'NONE'));
      } else {
        int index = _getProjectWithTitle(todo['parent']);
        if (index != -1) {
          projects[index].addTask(Task(
              title: todo['title'],
              isDone: todo['isDone'] == 1,
              parent: todo['parent']));
        } else {
          projects.add(
            Project(title: todo['parent'], tasks: [
              Task(
                title: todo['title'],
                isDone: todo['isDone'] == 1,
                parent: todo['parent'],
              ),
            ]),
          );
        }
      }
    }
    notifyListeners();
  }

  bool addProject(Project project) {
    if (project.title == null || project.title == '') {
      return false;
    }
    for (Project prevProject in projects) {
      if (prevProject.title == project.title) {
        return false;
      }
    }
    projects.add(project);
    notifyListeners();
    return true;
  }

  void deleteProject(Project project) {
    for (Task task in project.tasks) {
      DatabaseHelper.dbHelper.deleteTask(task);
    }
    projects.remove(project);
    notifyListeners();
  }

  void toggleTaskfromProject(Task task) {
    task.toggleCheck();
    notifyListeners();
  }

  bool addToProject(Task task, Project project) {
    if (task.title == null || task.title == '') {
      return false;
    }
    for (Task prevTask in project.tasks) {
      if (prevTask.title == task.title) {
        return false;
      }
    }
    project.tasks.add(task);
    addtoDatabase(task);
    notifyListeners();
    return true;
  }

  void deletefromProject(Task task, Project project) {
    DatabaseHelper.dbHelper.deleteTask(task);
    project.tasks.remove(task);
    notifyListeners();
  }

  int _getProjectWithTitle(String title) {
    for (int i = 0; i < projects.length; i++) {
      if (projects[i].title == title) {
        return i;
      }
    }
    return -1;
  }
}
