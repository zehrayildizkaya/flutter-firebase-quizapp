import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  const GradientBox({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.teal, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child:child,
    );
  }
}
