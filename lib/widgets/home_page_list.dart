import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/models/todo_data.dart';
import 'package:todoapp/screens/pop_up_menu.dart';
import 'package:todoapp/widgets/add_button.dart';
import 'package:todoapp/widgets/add_project.dart';
import 'package:todoapp/widgets/projects_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'task_list.dart';

class HomePageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AppLocalizations.of(context)!.welcome} ${FirebaseAuth.instance.currentUser?.displayName}',
                style: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    print('Signing out');
                    context.read<ToDoData>().clearData();
                    await FirebaseAuth.instance.signOut();
                  },
                  child: Text(AppLocalizations.of(context)!.sign_out))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.lists,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),
              ),
              Text('${context.watch<ToDoData>().projects.length} projects'),
            ],
          ),
        ),
        ProjectsList(
          projects: context.watch<ToDoData>().projects,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.quick_tasks,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),
              ),
              Text('${context.watch<ToDoData>().tasks.length} tasks'),
            ],
          ),
        ),
        TasksList(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: AddButton(
                onTap: () async {
                  bool wasSuccessful = await showDialog(
                    context: context,
                    builder: (context) {
                      return NewDialog();
                    },
                  );
                  if (!wasSuccessful) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Title has to be unique and non-empty'),
                      ),
                    );
                  }
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 54.0,
                  child: RawMaterialButton(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AddProjectView();
                          });
                    },
                    fillColor: kPrimaryAccentColor,
                    child: Icon(
                      Icons.playlist_add,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
