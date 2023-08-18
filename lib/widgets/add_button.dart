import 'package:flutter/material.dart';
import 'package:todoapp/constants.dart';

class AddButton extends StatelessWidget {
  final Function onTap;
  AddButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: kBlackColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  size: 20.0,
                  color: kBlackColor,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Add new task...',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//return Padding(
//padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
//child: GestureDetector(
//onTap: onTap,
//child: Container(
//width: double.infinity,
//height: 47.5,
//child: Row(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
////              Icon(
////                Icons.add,
////                size: 32.0,
////                color: Colors.white,
////              ),
//Text(
//'Add',
//style: TextStyle(
//fontSize: 20.0,
//fontWeight: FontWeight.w500,
//color: Colors.white,
//),
//),
//],
//),
//decoration: BoxDecoration(
//color: kPrimaryAccentColor,
//borderRadius: BorderRadius.circular(28.0),
//),
//),
//),
//);
