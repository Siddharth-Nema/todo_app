import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/project.dart';
import 'package:todoapp/models/todo_data.dart';

import '../constants.dart';

class AddProjectView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _title;
    return Dialog(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Container(
        height: 112.0,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              height: 64.0,
              child: TextField(
                onChanged: (newValue) {
                  _title = newValue;
                },
                cursorColor: kBlackColor,
                decoration: InputDecoration(
                  hintText: 'Enter title',
                  hintStyle: TextStyle(
                    color: Color(0xFFD7D7D7),
                    fontWeight: FontWeight.w300,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 2.0),
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
            ),
            Container(
              height: 48.0,
              width: double.infinity,
              child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                )),
                child: Text(
                  'Create new list',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                fillColor: kPrimaryAccentColor,
                onPressed: () {
                  bool wasSuccessful = context.read<ToDoData>().addProject(
                        Project(
                          title: _title,
                        ),
                      );
                  Navigator.pop(context, wasSuccessful);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
