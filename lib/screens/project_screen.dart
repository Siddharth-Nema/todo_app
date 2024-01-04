import 'package:flutter/material.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/models/project.dart';
import 'package:todoapp/widgets/project_page_list.dart';

class ProjectScreen extends StatelessWidget {
  final Project project;
  ProjectScreen({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: ProjectPageList(project: project),
      ),
    );
  }
}
