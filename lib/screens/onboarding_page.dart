import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

    void submit() {
      if (_nameController.text != "" && isValidEmail(_emailController.text)) {
        FirebaseAuth _auth = FirebaseAuth.instance;
        _auth.currentUser?.updateDisplayName(_nameController.text);
        _auth.currentUser?.updateEmail(_emailController.text);
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
              decoration: InputDecoration(labelText: "Name"),
              controller: _nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value == "" ? "Name cannot be empty" : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Email"),
              controller: _emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  isValidEmail(value) ? null : "Invalid Email",
            ),
            ElevatedButton(onPressed: submit, child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
