import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/models/todo_data.dart';

import 'screens/home_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(ChangeNotifierProvider<ToDoData>(
    child: MyApp(),
    create: (_) => ToDoData(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'SourceSansPro',
        splashColor: kPrimaryAccentColor,
        textTheme: TextTheme(
          body1: TextStyle(color: kBlackColor),
        ),
      ),
    );
  }
}
