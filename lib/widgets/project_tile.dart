import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/models/project.dart';
import 'package:todoapp/models/todo_data.dart';
import 'package:todoapp/screens/project_screen.dart';
import 'package:todoapp/widgets/reusable_card.dart';

class ProjectTile extends StatelessWidget {
  final Project project;

  ProjectTile({required this.project});

  @override
  Widget build(BuildContext context) {
    int taskPercentage() {
      int res = 0;
      try {
        res = ((project.completedTasks() * 100) / project.tasks.length).ceil();
      } catch (e) {
        res = 0;
      }

      return res;
    }

    double taskPercentageDouble() {
      double res = 0.0;
      if (project.tasks.length == 0) {
        res = 0.0;
      } else {
        res = project.completedTasks() / project.tasks.length;
      }
      return res;
    }

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPress: () {
          context.read<ToDoData>().deleteProject(project);
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProjectScreen(
                  project: project,
                );
              },
            ),
          );
        },
        child: ReusableCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    project.title,
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                ),
                width: 120.0,
              ),
              Container(
                width: 120.0,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: LinearProgressIndicator(
                  value: taskPercentageDouble(),
                  backgroundColor: Color(0xFFD7D7D7),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(kPrimaryAccentColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('${taskPercentage().toString()}% completed'),
              ),
              //Text(taskPercentageDouble().toString()),
            ],
          ),
        ),
      ),
    );
  }
}
