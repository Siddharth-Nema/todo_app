import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/todo_data.dart';

class PopUpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String taskTitle;
    return SimpleDialog(
      children: <Widget>[
        Text(
          'Task',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        TextField(
          onChanged: (newValue) {
            taskTitle = newValue;
          },
          cursorColor: kBlackColor,
          decoration: InputDecoration(
            focusColor: kPrimaryAccentColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          autofocus: true,
          autocorrect: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
          color: kPrimaryAccentColor,
          onPressed: () {
            bool wasSuccessful =
                context.read<ToDoData>().addTask(Task(title: taskTitle));
            Navigator.pop(context, wasSuccessful);
          },
        ),
      ],
    );
  }
}
