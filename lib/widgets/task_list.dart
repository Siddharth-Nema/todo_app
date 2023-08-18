import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo_data.dart';

import 'task_tile.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  void initState() {
    super.initState();
    //getData();
  }

  void getData() async {
    context.read<ToDoData>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return TaskTile(
            task: context.watch<ToDoData>().tasks[index],
            onChanged: () {
              context
                  .read<ToDoData>()
                  .toggleCheck(context.read<ToDoData>().tasks[index]);
            },
            onLongTap: () {
              context
                  .read<ToDoData>()
                  .deleteTask(context.read<ToDoData>().tasks[index]);
            },
          );
        },
        itemCount: context.watch<ToDoData>().tasks.length,
      ),
    );
  }
}
