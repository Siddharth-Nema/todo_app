import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/project.dart';
import 'package:todoapp/models/todo_data.dart';
import 'package:todoapp/screens/projectview_popup.dart';
import 'package:todoapp/widgets/task_tile.dart';

import '../constants.dart';
import 'add_button.dart';

class ProjectPageList extends StatefulWidget {
  final Project project;
  ProjectPageList({this.project});
  @override
  _ProjectPageListState createState() => _ProjectPageListState();
}

class _ProjectPageListState extends State<ProjectPageList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(maxWidth: 25.0),
          child: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.project.title,
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 24.0,
                ),
              ),
              Text('${widget.project.tasks.length} tasks'),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskTile(
                task: widget.project.tasks[index],
                onChanged: () {
                  setState(() {
                    context
                        .read<ToDoData>()
                        .toggleCheck(widget.project.tasks[index]);
                  });
                },
                onLongTap: () {
                  setState(() {
                    context.read<ToDoData>().deletefromProject(
                        widget.project.tasks[index], widget.project);
                  });
                },
              );
            },
            itemCount: widget.project.tasks.length,
          ),
        ),
        AddButton(
          onTap: () async {
            bool wasSuccessful = await showDialog(
              context: context,
              builder: (context) {
                return ProjectAddDialog(
                  project: widget.project,
                );
              },
            );
            setState(() {});
            if (!wasSuccessful) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Title has to be unique and non-empty'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
