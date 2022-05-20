import 'package:flutter/material.dart';

class ArkaPlan extends StatelessWidget {
  const ArkaPlan({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 98, 223, 128),
          Color.fromARGB(255, 30, 75, 35)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: child,
    );
  }
}
