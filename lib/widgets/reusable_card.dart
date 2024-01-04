import 'package:flutter/material.dart';
import 'package:todoapp/constants.dart';

class ReusableCard extends StatelessWidget {
  final Widget child;

  ReusableCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kSecondaryBlueColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(0.0, 2.0),
              color: Color.fromARGB(255, 0, 0, 0),
              spreadRadius: .5,
              blurRadius: 3.0,
            )
          ]),
      child: child,
    );
  }
}
