import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/screens/otp_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller = new TextEditingController();
  TextEditingController _countryCodeController = new TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    String phoneNumber = _countryCodeController.text + _controller.text;
    print(phoneNumber);
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
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
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      8, MediaQuery.of(context).size.height / 5, 8, 50),
                  child: Image.asset(
                    'assets/app_logo.png',
                    scale: 1,
                  ),
                ),
                Row(
                  children: [
                    DropdownMenu(
                      textStyle: TextStyle(fontSize: 20, letterSpacing: 1.2),
                      trailingIcon: Icon(Icons.arrow_drop_down_rounded),
                      hintText: "00",
                      controller: _countryCodeController,
                      dropdownMenuEntries: <DropdownMenuEntry>[
                        DropdownMenuEntry(value: '+91', label: '+91')
                      ],
                      width: 105,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 20, letterSpacing: 1.2),
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter phone number',
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 16)),
                          textStyle: MaterialStatePropertyAll(
                            TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
                          ),
                          backgroundColor:
                              MaterialStatePropertyAll(kPrimaryAccentColor)),
                      onPressed: login,
                      child: Text(AppLocalizations.of(context)!.send_otp)),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 30.0)),
                        textStyle: MaterialStatePropertyAll(
                          TextStyle(fontSize: 16.0),
                        ),
                        backgroundColor:
                            MaterialStatePropertyAll(kPrimaryAccentColor)),
                    onPressed: loginAnonymously,
                    child: Text(AppLocalizations.of(context)!.guest_login))
              ]),
        ),
      ),
    );
  }
}
