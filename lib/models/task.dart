class Task {
  String id;
  bool isDone = false;
  String title = '';
  String parent = '';

  Task(
      {this.isDone = false,
      required this.title,
      this.parent = 'NONE',
      this.id = ''});

  void toggleCheck() {
    isDone = !isDone;
  }

  void addID(String dbID) {
    this.id = dbID;
  }
}
