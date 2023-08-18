import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Widget child;

  ReusableCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(0.0, 0.0),
                color: Color(0x10000000),
                spreadRadius: 0.1,
                blurRadius: 8.0,
              )
            ]),
        child: child,
      ),
    );
  }
}
