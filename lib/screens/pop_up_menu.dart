import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/todo_data.dart';
import 'package:todoapp/widgets/add_project.dart';
import 'package:todoapp/widgets/add_task.dart';

class NewDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //String taskTitle;
    TabController tabController;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: AddTaskView(
        onAdd: (String taskTitle) {
          bool wasSuccessful =
              context.read<ToDoData>().addTask(Task(title: taskTitle));
          Navigator.pop(context, wasSuccessful);
        },
      ),
    );
  }
}

//
//SimpleDialog(
//contentPadding: EdgeInsets.all(0.0),
//children: [
//Container(
//height: 200.0,
//width: 200.0,
//child: DefaultTabController(
//length: 2,
//child: Scaffold(
//appBar: TabBar(
//indicatorColor: kPrimaryAccentColor,
//indicatorSize: TabBarIndicatorSize.label,
//controller: tabController,
//tabs: <Widget>[
//Tab(
//child: Text(
//'Task',
//style: TextStyle(color: kBlackColor),
//),
//),
//Tab(
//child: Text(
//'List',
//style: TextStyle(color: kBlackColor),
//),
//),
//],
//),
//body: TabBarView(
//children: <Widget>[
//AddTaskView(
//onAdd: (String taskTitle) {
//bool wasSuccessful = context
//    .read<ToDoData>()
//    .addTask(Task(title: taskTitle));
//Navigator.pop(context, wasSuccessful);
//},
//),
//AddProjectView(),
//],
//),
//),
//),
//),
//],
//);
