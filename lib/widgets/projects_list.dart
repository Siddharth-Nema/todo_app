import 'package:flutter/material.dart';
import 'package:todoapp/models/project.dart';
import 'package:todoapp/widgets/project_tile.dart';

class ProjectsList extends StatelessWidget {
  final List<Project> projects;

  ProjectsList({this.projects});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        itemBuilder: (context, index) {
          Project project = projects[index];
          return ProjectTile(
            project: project,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
      ),
    );
  }
}
