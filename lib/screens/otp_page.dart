import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pinput/pinput.dart';
import '../constants.dart';

class OtpPage extends StatelessWidget {
  final Function verifyOTP;
  const OtpPage({super.key, required this.verifyOTP});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Enter OTP",
              style: TextStyle(fontSize: 24),
            ),
          ),
          Text(
            "Enter The OTP sent to +91",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              showCursor: true,
              onCompleted: (pin) async {
                await verifyOTP(pin);
                Navigator.pop(context);
              },
            ),
          ),
          Text(
            "Didn't recieve the code",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            "Resend",
            style: TextStyle(fontSize: 14, color: Colors.amber),
          ),
        ],
      ),
    );
  }
}
