import 'package:todoapp/models/task.dart';

class Project {
  late String? id;
  String title;
  List<Task> tasks;

  Project({required this.tasks, required this.title, this.id}) {
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

  void addID(String id) {
    this.id = id;
  }
}
