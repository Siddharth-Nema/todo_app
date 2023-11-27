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
import 'package:todoapp/screens/onboarding_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('hi'),
      ],
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            print(user);
            if (user == null) {
              return LoginPage();
            } else if (user.displayName == null) {
              return OnBoardingPage();
            } else {
              DatabaseHelper.dbHelper.configurUser();
              return HomePage();
            }
          } else {
            return LoginPage();
          }
        },
      ),
      theme: ThemeData(
        fontFamily: 'SourceSansPro',
        splashColor: kPrimaryAccentColor,
      ),
    );
  }
}
