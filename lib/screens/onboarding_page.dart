import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/screens/home_page.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  bool isValidEmail(String? email) {
    String mail = email ?? "";

    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(mail);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _emailController = new TextEditingController();

    void submit() async {
      if (_nameController.text != "" && isValidEmail(_emailController.text)) {
        FirebaseAuth _auth = FirebaseAuth.instance;
        await _auth.currentUser?.updateDisplayName(_nameController.text);
        print(_auth.currentUser);
        //_auth.currentUser?.updateEmail(_emailController.text);
        // Navigator.of(context)
        //     .pushReplacement(MaterialPageRoute(builder: (context) {
        //   return HomePage();
        // }));
      } else {
        print("Something wrong");
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome to ToDo",
              style: TextStyle(fontSize: 32.0),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.name),
              controller: _nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value == ""
                  ? AppLocalizations.of(context)!.name_cannot_be_empty
                  : null,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.email),
              controller: _emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => isValidEmail(value)
                  ? null
                  : AppLocalizations.of(context)!.invalid_email,
            ),
            ElevatedButton(
                onPressed: submit,
                child: Text(AppLocalizations.of(context)!.submit))
          ],
        ),
      ),
    );
  }
}
