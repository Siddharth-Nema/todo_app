import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/models/todo_data.dart';
import 'package:todoapp/widgets/home_page_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ToDoData>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: HomePageList(),
      ),
    );
  }
}
