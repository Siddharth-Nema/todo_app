import 'package:flutter/material.dart';
import 'package:todoapp/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskView extends StatelessWidget {
  final Function onAdd;

  AddTaskView({required this.onAdd});
  @override
  Widget build(BuildContext context) {
    late String taskTitle;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: kSecondaryBlueColor,
      ),
      height: 64.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: TextField(
                  onChanged: (newValue) {
                    taskTitle = newValue;
                  },
                  cursorColor: kBlackColor,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enter_task,
                    hintStyle: TextStyle(
                      color: Color(0xFFD7D7D7),
                    ),
                    focusColor: kPrimaryAccentColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  autofocus: true,
                  autocorrect: true,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      onAdd(taskTitle);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    fillColor: kPrimaryAccentColor,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
