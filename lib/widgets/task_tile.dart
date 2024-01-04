import 'package:flutter/material.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/widgets/reusable_card.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function onChanged;
  final Function onLongTap;

  TaskTile(
      {required this.task, required this.onChanged, required this.onLongTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 6.0,
      ),
      child: ReusableCard(
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(
                color: task.isDone
                    ? Color.fromARGB(93, 215, 215, 215)
                    : Colors.white,
                decoration: task.isDone ? TextDecoration.lineThrough : null),
          ),
          onTap: () {
            onChanged();
          },
          onLongPress: () {
            onLongTap();
          },
          trailing: Checkbox(
            value: task.isDone,
            checkColor: Colors.white,
            activeColor: kPrimaryAccentColor,
            onChanged: (status) {
              onChanged();
            },
          ),
        ),
      ),
    );
  }
}
