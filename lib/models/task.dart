class Task {
  bool isDone;
  String title;
  String parent;

  Task({this.isDone = false, this.title, this.parent = 'NONE'});

  void toggleCheck() {
    isDone = !isDone;
  }
}
