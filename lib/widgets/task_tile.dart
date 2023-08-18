import 'package:flutter/material.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/widgets/reusable_card.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function onChanged;
  final Function onLongTap;

  TaskTile({this.task, this.onChanged, this.onLongTap});

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
              color: task.isDone ? Color(0xFFD7D7D7) : kBlackColor,
              fontWeight: FontWeight.w100,
            ),
          ),
          onTap: onChanged,
          onLongPress: onLongTap,
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
