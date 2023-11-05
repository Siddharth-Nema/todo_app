import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/models/database_helper.dart';
import 'package:todoapp/models/todo_data.dart';
import 'package:todoapp/screens/login_page.dart';

import 'screens/home_page.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user != null) {
              return HomePage();
            }
          }
          return LoginPage();
        },
      ),
      theme: ThemeData(
        fontFamily: 'SourceSansPro',
        splashColor: kPrimaryAccentColor,
      ),
    );
  }
}
