import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/otp_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller = new TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    await auth.verifyPhoneNumber(
      phoneNumber: _controller.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        } else {
          print(e.code);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OtpPage(
            verifyOTP: (String otp) async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: otp);
              await auth.signInWithCredential(credential);
            },
          );
        }));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> loginAnonymously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            controller: _controller,
          ),
          ElevatedButton(
              onPressed: login,
              child: Text(AppLocalizations.of(context)!.send_otp)),
          ElevatedButton(
              onPressed: loginAnonymously,
              child: Text(AppLocalizations.of(context)!.guest_login))
        ]),
      ),
    );
  }
}
