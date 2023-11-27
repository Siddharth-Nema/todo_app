import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          TextField(
            controller: _controller,
          ),
          ElevatedButton(
              onPressed: () async {
                await verifyOTP(_controller.text);
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.verify_otp))
        ],
      ),
    );
  }
}
