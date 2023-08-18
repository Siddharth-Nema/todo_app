import 'package:todoapp/models/task.dart';

class Project {
  String title;
  List<Task> tasks;

  Project({this.tasks, this.title = ''}) {
    tasks = [];
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  int completedTasks() {
    int sum = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].isDone == true) sum++;
    }
    return sum;
  }
}
