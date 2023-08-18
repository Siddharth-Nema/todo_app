import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/project.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/todo_data.dart';
import 'package:todoapp/widgets/add_task.dart';

class ProjectAddDialog extends StatelessWidget {
  final Project project;
  ProjectAddDialog({this.project});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: AddTaskView(
        onAdd: (String taskTitle) {
          bool wasSuccessful = context.read<ToDoData>().addToProject(
              Task(title: taskTitle, parent: project.title), project);
          Navigator.pop(context, wasSuccessful);
        },
      ),
    );
  }
}
